class CreateSpreeBlogEntriesTags < ActiveRecord::Migration
  def change
    create_table :spree_blog_entry_tags do |t|
      t.belongs_to :blog_entry
      t.references :tag
 
      t.timestamps null: false
    end

    add_index :spree_blog_entry_tags, [:blog_entry_id, :tag_id], unique: true, name: 'idx_uniq_blog_entry_tag'
  end
end
