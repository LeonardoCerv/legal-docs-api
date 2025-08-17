class AcceptableUsePolicy < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :effective_date, presence: true
  validates :prohibited_content, presence: true
  validates :prohibited_activities, presence: true
  validates :user_responsibilities, presence: true
  validates :user_id, uniqueness: true

  validates :effective_date, comparison: { greater_than_or_equal_to: Date.current }, on: :create

  scope :active, -> { where('effective_date <= ?', Date.current) }
  scope :with_age_restrictions, -> { where(age_restrictions: true) }
  scope :with_content_moderation, -> { where(content_moderation: true) }

  validate :enforcement_consistency

  private

  def enforcement_consistency
    if content_moderation && enforcement_actions.blank?
      errors.add(:enforcement_actions, "must be specified when content moderation is enabled")
    end
  end
end
