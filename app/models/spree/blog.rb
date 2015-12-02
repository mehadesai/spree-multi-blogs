class Spree::Blog < ActiveRecord::Base
  include FriendlyId
  friendly_id :slug_candidates, use: :history

  has_many :blog_entries, dependent: :destroy

  acts_as_paranoid

  before_create :set_slug

  validates_presence_of :name
  # can add a validation to allow enabling only if AT LEAST ONE blog entry is present

  SLUG_LENGTH = 20

  def set_slug
    self.slug = name.to_url[0..(SLUG_LENGTH - 1)] if slug.blank?
  end
end 
