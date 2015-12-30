Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :blogs do
      resources :blog_entries
    end
  end
  get '/:slug/:year/:month/:permalink' => 'blog_entries#show', as: :blog_entry_permalink
end
