module Spree
  class Blog < Spree::Base
    has_many :blog_entries, dependent: :destroy

    acts_as_paranoid

    after_create :set_css_path

    validates_presence_of :name
    validates :name, uniqueness: { case_sensitive: false } 
    validates_uniqueness_of :slug
    # can add a validation to allow enabling only if AT LEAST ONE blog entry is present

    SLUG_LENGTH = 20
    RECENT_POSTS = 10
    scope :enabled, -> { where(enabled: true) }

    def set_css_path
      self.css_path = 'spree/frontend/' + slug
    end

    def recent
      blog_entries.visible.published.limit(RECENT_POSTS)
    end

    def self.retrieve_slugs
      Spree::Blog.enabled.collect(&:slug)
    end
  end
end 
