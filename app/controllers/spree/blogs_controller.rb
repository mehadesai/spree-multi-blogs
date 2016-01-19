class Spree::BlogsController < Spree::StoreController
  before_filter :init_pagination, only: :show
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  PER_PAGE = 10

  def show
    params[:q] ||= {}

    @blog = Spree::Blog.find_by_slug(params[:slug])
    render_404 and return if @blog.blank?

    @search = @blog.blog_entries.ransack(params[:q])
    @blog_entries = @search.result.page(@pagination_page).per(@pagination_per_page)
    @blog_entries = @blog_entries.includes(:tags, author: [:user_detail])
    @blog_entries = if try_spree_current_user.try(:has_spree_role?, 'admin')
                      @blog_entries.published
                    else
                      # takes care of non-admin and logged out users
                      @blog_entries.visible.published
                    end
    @blog_entries = @blog_entries.page(@pagination_page).per(@pagination_per_page)

    @title = @blog.meta_title
    @meta_description = @blog.meta_description
    @meta_keywords = @blog.meta_keywords
  end

  private

    def init_pagination
      @pagination_page = params[:page].to_i > 0 ? params[:page].to_i : 1
      @pagination_per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : PER_PAGE
    end
end
