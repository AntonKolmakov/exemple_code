class Post < ActiveRecord::Base
  extend FriendlyId

  belongs_to :category
  has_many :post_attachments
  accepts_nested_attributes_for :post_attachments, allow_destroy: true

  validates :name, presence: true

  friendly_id :name, use: %i(slugged history)

  def should_generate_new_friendly_id?
    name_changed? || slug_changed?
  end
end
