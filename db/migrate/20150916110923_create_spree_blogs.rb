class CreateSpreeBlogs < ActiveRecord::Migration
  def change
    create_table :spree_blogs do |t|
      t.string :name
      t.string :slug, limit: 20
      t.boolean :enabled, default: false
      t.boolean :private, default: false
      t.string :css_path
      t.datetime :deleted_at, default: nil

      t.timestamps null: false
    end
    add_index :spree_blogs, :slug
    add_index :spree_blogs, :enabled
    add_index :spree_blogs, :private
  end
end
