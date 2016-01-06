class CreateBlogEntries < ActiveRecord::Migration
  def self.up
    create_table :spree_blog_entries do |t|
      t.belongs_to :blog
      t.column :title, :string
      t.column :body, :text
      t.column :summary, :text
      t.column :permalink, :string
      t.column :visible, :boolean, default: false
      t.column :published_at, :datetime
      t.column :author_id, :integer
      t.timestamps
    end

    add_index :spree_blog_entries, [:blog_id, :permalink], unique: true, name: 'idx_uniq_blog_entries'
  end

  def self.down
    drop_table :spree_blog_entries
  end
end