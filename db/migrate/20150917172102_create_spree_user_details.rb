class CreateSpreeUserDetails < ActiveRecord::Migration
  def change
    create_table :spree_user_details do |t|
      t.belongs_to :user
      t.string :nickname
      t.string :website_url
      t.string :google_plus_url
      t.text :bio_info
    end

    add_index :spree_user_details, :user_id
    add_index :spree_user_details, :nickname
  end
end
