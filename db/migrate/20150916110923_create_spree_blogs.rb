class CreateSpreeBlogs < ActiveRecord::Migration
  def change
    create_table :spree_blogs do |t|
      t.string :name
      t.boolean :enabled, default: true
      t.datetime :deleted_at, default: nil

      t.timestamps null: false
    end
  end
end
