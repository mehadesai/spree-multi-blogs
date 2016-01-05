module Spree
  module Admin
    class BlogEntriesController < ResourceController
      PER_PAGE = 30

      def index
        params[:q] ||= {}
        params[:q][:deleted_at_null] ||= '1'

        @blog = Spree::Blog.find(params[:blog_id])
        @blog_entries = @blog_entries.unscoped if params[:q].delete(:deleted_at_null) == '0'
        @search = @blog_entries.ransack(params[:q])
        @blog_entries = @search.result.page(params[:page]).per(PER_PAGE)
      end

      def update
        if params[:blog_entry].present? && params[:blog_entry][:deleted_at].present?
          params[:blog_entry][:deleted_at] = params[:blog_entry][:deleted_at] == '0' ? nil : Time.now
        end
        blog_entry_params.merge(author_id: spree_current_user.id)
        @blog = Spree::Blog.find(params[:blog_id])
        result = @blog_entry.update_attributes(blog_entry_params)
        if result
          flash[:success] = flash_message_for(@blog_entry, :successfully_updated)
          respond_with(@blog_entry) do |format|
            format.html { redirect_to admin_blog_blog_entries_path }
            format.json { render layout: false, status: :updated }
          end
        else
          invoke_callbacks(:update, :fails)
          respond_with(@blog_entry)
        end
      end

      private
        def location_after_save
          edit_admin_blog_url(@blog_entry.blog)
        end

        def collection
          page = params[:page].to_i > 0 ? params[:page].to_i : 1
          per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : 20
          Spree::BlogEntry.where(blog_id: params[:blog_id]).page(page).per(per_page)
        end

      private
        def load_data
          @blog = Spree::Blog.find(params[:blog_id])
        end

        def blog_entry_params
          params.require(:blog_entry).permit(:title, :visible, :blog_id, :body, :permalink, :author_id, :summary, :published_at)
        end
    end
  end
end
