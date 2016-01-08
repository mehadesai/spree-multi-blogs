module Spree
  module Admin
    class BlogsController < ResourceController
      def index
        params[:q] ||= {}
        params[:q][:deleted_at_null] ||= "1"

        @blogs = @blogs.unscoped if params[:q].delete(:deleted_at_null) == '0'
        @search = @blogs.ransack(params[:q])
        @blogs = @search.result.page(params[:page]).per(Spree::Config[:admin_products_per_page])
      end

      def create
        if params[:blog][:slug].blank?
          slug = params[:blog][:name].to_url[0..(Spree::Blog::SLUG_LENGTH - 1)]
          params[:blog] = params[:blog].merge!({ slug: slug })
        end
        @blog = Spree::Blog.create(blog_params)
        if @blog.errors.blank?
          flash[:success] = flash_message_for(@blog, :successfully_created)
          respond_with(@blog) do |format|
            format.html { redirect_to admin_blogs_path }
            format.json { render layout: false, status: :created }
          end
        else
          invoke_callbacks(:create, :fails)
          respond_with(@blog)
        end
      end

      def update
        if params[:blog].present? && params[:blog][:deleted_at].present?
          params[:blog][:deleted_at] = params[:blog][:deleted_at] == '0' ? nil : Time.now
        end
        result = @blog.update_attributes(blog_params)
        if result
          flash[:success] = flash_message_for(@blog, :successfully_updated)
          respond_with(@blog) do |format|
            format.html { redirect_to admin_blogs_path }
            format.json { render layout: false, status: :updated }
          end
        else
          invoke_callbacks(:update, :fails)
          respond_with(@blog)
        end
      end

      protected
        def location_after_save
          edit_admin_blog_url(@blog)
        end

        def collection
          page = params[:page].to_i > 0 ? params[:page].to_i : 1
          per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : 20
          Spree::Blog.page(page).per(per_page)
        end


      private
        def blog_params
          params.require(:blog).permit(:name, :enabled, :private, :slug, :css_path, :meta_title, :deleted_at)
        end
    end
  end
end

