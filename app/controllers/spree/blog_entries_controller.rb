class Spree::BlogEntriesController < Spree::StoreController
  helper 'spree/blog_entries' 

  before_filter :init_pagination, only: :index
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  
  def index
    @blog_entries = Spree::BlogEntry.visible.page(@pagination_page).per(@pagination_per_page)
  end
  
  def show
    permalink = [params[:slug], params[:year], params[:month], params[:permalink]].join('/')
    if try_spree_current_user.try(:has_spree_role?, 'admin')
      @blog_entry = Spree::BlogEntry.find_by_permalink!(permalink)
    else
      # takes care of non-admin and logged out users
      @blog_entry = Spree::BlogEntry.include(:blog).visible.published.find_by(permalink: permalink, 
                                                                              spree_blogs: { enabled: true, 
                                                                                             private: false } )
    end
    @title = @blog_entry.title
  end

  private

    def init_pagination
      @pagination_page = params[:page].to_i > 0 ? params[:page].to_i : 1
      @pagination_per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : 10
    end
end
