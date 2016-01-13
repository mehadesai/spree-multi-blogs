class AddTitleImageToBlogEntry < ActiveRecord::Migration
  def change
    add_column :spree_blog_entries, :title_image, :string, after: :title
    add_column :spree_blog_entries, :title_image_alt, :string, after: :title_image
  end
end
