class AddMetaInfoToBlogs < ActiveRecord::Migration
  def change
    add_column :spree_blog_entries, :meta_description, :string, after: :meta_title
    add_column :spree_blogs, :meta_description, :string, after: :meta_title
    add_column :spree_blogs, :meta_keywords, :string, after: :meta_description
  end
end
