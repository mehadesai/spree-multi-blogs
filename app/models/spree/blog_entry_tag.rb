module Spree
  class BlogEntryTag < Spree::Base
    belongs_to :blog_entry, touch: true
    belongs_to :tag
  end
end
