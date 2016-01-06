Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :blogs do
      resources :blog_entries
    end
  end
  
  get '/:slug' => 'blogs#show',
     constraints: -> (req) {
                            blog_slug = req.path.split('/').delete_if(&:empty?).first;
                            Spree::Blog.retrieve_slugs.include?(blog_slug)
                          }

  get '/:slug/:year/:month/:permalink' => 'blog_entries#show',
    as: :blog_entry_permalink,
    constraints: -> (req) {
                            blog_slug = req.path.split('/').delete_if(&:empty?).first;
                            Spree::Blog.retrieve_slugs.include?(blog_slug) 
                          }
end
