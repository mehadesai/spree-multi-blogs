Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :blogs do
      resources :blog_entries
    end
  end
  
  get '/:slug/:year/:month/:permalink' => 'blog_entries#show',
    as: :blog_entry_permalink_new,
    constraints: -> (req) {
                            blog_slug = req.path.split('/').delete_if(&:empty?).first;
                            Spree::Blog.retrieve_slugs.include?(blog_slug) 
                          }
end
