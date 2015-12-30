class CreateSpreeBlogsAccess < ActiveRecord::Migration
  def change
    create_table :spree_blogs_access do |t|
      t.references :blog
      t.references :role
    end
  end
end
