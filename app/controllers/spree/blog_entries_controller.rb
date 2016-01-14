class Spree::BlogEntriesController < Spree::StoreController
  helper 'spree/blog_entries' 
 
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def show
    permalink = [params[:slug], params[:year], params[:month], params[:permalink]].join('/')
    if try_spree_current_user.try(:has_spree_role?, 'admin')
      @blog_entry = Spree::BlogEntry.find_by_permalink!(permalink)
    else
      # takes care of non-admin and logged out users
      @blog_entry = Spree::BlogEntry.includes(:blog).visible.published.find_by(permalink: permalink,
                                                                              spree_blogs: { enabled: true,
                                                                                             private: false } )
    end
    render_404 and return if @blog_entry.blank?
    @meta_title = @blog_entry.meta_title
    @meta_description = @blog_entry.meta_description
    @meta_keywords = @blog_entry.meta_keywords
  end
end
