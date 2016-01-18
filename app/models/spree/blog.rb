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

    def tags_by_type(count, type)
      tags_data = blog_entries.includes(:tags)
      tags_data = if type == 'recent'
                    tags_data.order('spree_blog_entries_tags.updated_at DESC')
                  elsif type == 'top'
                    tags_data
                  end
      tags_hash = {}
      # tags_hash = tags_hash.each { |be| be.tags.inject(Hash.new(1)) { |h, t| h[t.name] += 1; h } }
      tags_data.each { |be| be.tags.each { |t| tags_hash[t.name] = tags_hash[t.name].present? ? tags_hash[t.name] += 1 : 1 } }
      tags_hash.first(count).to_h
    end

    def self.retrieve_slugs
      Spree::Blog.enabled.collect(&:slug)
    end
  end
end 
