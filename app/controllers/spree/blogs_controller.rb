class Spree::BlogsController < Spree::StoreController
  before_filter :init_pagination, only: :show
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  PER_PAGE = 10

  def show
    @blog = Spree::Blog.find_by_slug(params[:slug])

    if try_spree_current_user.try(:has_spree_role?, 'admin')
      @blog_entries = @blog.blog_entries.published.page(@pagination_page).per(@pagination_per_page)
    else
      # takes care of non-admin and logged out users
      @blog_entries = @blog.blog_entries.visible.published.page(@pagination_page).per(@pagination_per_page)
    end
    @meta_title = @blog.meta_title
    @meta_description = @blog.meta_description
    @meta_keywords = @blog.meta_keywords
  end

  private

    def init_pagination
      @pagination_page = params[:page].to_i > 0 ? params[:page].to_i : 1
      @pagination_per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : PER_PAGE
    end
end
