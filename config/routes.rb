Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :blogs do
      resources :blog_entries
    end
  end

  resources :blog_entries
  get '/:blog_id/:slug' => 'blog_entries#show', as: :blog_entry_permalink

#  get '/blog/tag/:tag' => 'blog_entries#tag', :as => :blog_tag
#  get '/blog/category/:category' => 'blog_entries#category', :as => :blog_category
#  get '/blog/author/:author' => 'blog_entries#author', as: :blog_author
#  get '/blog/:year(/:month)(/:day)' => 'blog_entries#archive', :as => :news_archive, 
#    :constraints => {:year => /(19|20)\d{2}/, :month => /[01]?\d/, :day => /[0-3]?\d/}
#  get '/blog/feed' => 'blog_entries#feed', :as => :blog_feed, :format => :rss
#  get '/blog' => 'blog_entries#index', :as => :blog
end

