module Spree
  class Author < Spree::User
    belongs_to :user
    belongs_to :blog_entry

  end
end 
