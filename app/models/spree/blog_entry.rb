class Spree::BlogEntry < ActiveRecord::Base
  belongs_to :blog

  before_save :set_published_at
  before_save :set_permalink

  validates_presence_of :title
  validates_presence_of :body
  validates_uniqueness_of :blog_id, scope: :permalink

  default_scope { order('published_at DESC') }
  scope :visible, -> { where(visible: true) }
  scope :published, -> { where('published_at <= ?', Time.now) }

  if Spree.user_class
    belongs_to :author, :class_name => Spree.user_class.to_s
  else
    belongs_to :author
  end

  has_one :blog_entry_image, :as => :viewable, :dependent => :destroy, :class_name => 'Spree::BlogEntryImage'
  accepts_nested_attributes_for :blog_entry_image, :reject_if => :all_blank

  SUMMARY_CHARS = 200

  def entry_summary(chars=SUMMARY_CHARS)
    if summary.blank?
      "#{body[0...chars]}..."
    else
      summary
    end
  end

  private
  def set_permalink
    base_permalink = blog.slug + published_at.strftime('/%Y/%m/')
    permalink_part = if permalink.blank?
                       title
                     elsif permalink.start_with?(base_permalink)
                       permalink.split('/').last
                     else
                       permalink
                     end
    self.permalink = base_permalink + permalink_part.to_url
  end

  def set_published_at
    self.published_at = Time.now if published_at.blank?
  end
end 
