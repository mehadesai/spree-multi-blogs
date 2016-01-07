module Spree
  class Blog < Spree::Base
    has_many :blog_entries, dependent: :destroy

    acts_as_paranoid

    before_create :set_slug
    after_create :set_css_path

    validates_presence_of :name
    validates_uniqueness_of :name
    validates_uniqueness_of :slug
    # can add a validation to allow enabling only if AT LEAST ONE blog entry is present

    SLUG_LENGTH = 20
    RECENT_POSTS = 10
    scope :enabled, -> { where(enabled: true) }

    def set_slug
      self.slug = name.to_url[0..(SLUG_LENGTH - 1)] if slug.blank?
    end

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
