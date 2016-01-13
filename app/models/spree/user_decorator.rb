if Spree.user_class
  Spree.user_class.class_eval do
    has_many :blog_entries, :foreign_key => :author_id
    has_one :user_detail

    scope :authors, -> { includes(:spree_roles).where(spree_roles: { name: 'blogger' }) }
  end
end
