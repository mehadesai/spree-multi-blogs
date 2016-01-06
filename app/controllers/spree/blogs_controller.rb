class Spree::BlogsController < Spree::StoreController
  before_filter :init_pagination, only: :index
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  
  def index
    @blog_entries = Spree::BlogEntry.visible.page(@pagination_page).per(@pagination_per_page)
  end
  
  def show
    @blog = Spree::Blog.find_by_slug(params[:slug])
    @blog_entries = @blog.blog_entries
    unless try_spree_current_user.try(:has_spree_role?, 'admin')
      # takes care of non-admin and logged out users
      @blog_entries = @blog.blog_entries.visible.published
    end
    @blog_entries.page(@pagination_page).per(@pagination_per_page)
  end

  private

    def init_pagination
      @pagination_page = params[:page].to_i > 0 ? params[:page].to_i : 1
      @pagination_per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : 10
    end
end
