Spree::Tag.class_eval do
  has_and_belongs_to_many :blog_entries
end
