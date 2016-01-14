module Spree
  module Admin
    class AuthorsController < ResourceController
      def index
        params[:q] ||= {}
        params[:q][:deleted_at_null] ||= "1"

        @search = @authors.ransack(params[:q])
        @authors = @search.result.page(params[:page]).per(Spree::Config[:admin_products_per_page])
        @authors = @authors.includes(:user_detail)
      end

      def update
        author_info = Spree::UserDetail.find_or_create_by(user_id: params[:id])
        result = author_info.update_attributes(author_params[:user_detail])
        if result
          flash[:success] = flash_message_for(@author, :successfully_updated)
          respond_with(@author) do |format|
            format.html { redirect_to admin_authors_path }
            format.json { render layout: false, status: :updated }
          end
        else
          invoke_callbacks(:update, :fails)
          respond_with(@author)
        end
      end

      protected
        def collection
          page = params[:page].to_i > 0 ? params[:page].to_i : 1
          per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : 20
          Spree::User.authors.page(page).per(per_page)
        end


      private
        def author_params
          params.require(:author).permit(:id, { user_detail: [:nickname, :website_url, :bio_info] })
        end
    end
  end
end

