class CreateSpreeBlogs < ActiveRecord::Migration
  def change
    create_table :spree_blogs do |t|
      t.string :name
      t.string :slug
      t.boolean :enabled, default: false
      t.boolean :private, default: false
      t.string :css_path
      t.datetime :deleted_at, default: nil
      t.string :meta_title

      t.timestamps null: false
    end

    add_index :spree_blogs, :slug, unique: true
    add_index :spree_blogs, :enabled
    add_index :spree_blogs, :private
  end
end
