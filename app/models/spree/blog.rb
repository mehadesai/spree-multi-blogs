class Spree::Blog < ActiveRecord::Base
  has_many :blog_entries, dependent: :destroy

  acts_as_paranoid

  validates_presence_of :name
  # can add a validation to allow enabling only if AT LEAST ONE blog entry is present
end 
