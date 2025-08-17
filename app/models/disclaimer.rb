class Disclaimer < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :effective_date, presence: true
  validates :disclaimer_type, presence: true
  validates :user_id, uniqueness: true

  validates :effective_date, comparison: { greater_than_or_equal_to: Date.current }, on: :create

  DISCLAIMER_TYPE_OPTIONS = %w[general medical legal financial educational investment].freeze

  validates :disclaimer_type, inclusion: { in: DISCLAIMER_TYPE_OPTIONS }

  validates :professional_advice_disclaimer, inclusion: { in: [true] }, if: :requires_professional_disclaimer?

  scope :by_type, ->(type) { where(disclaimer_type: type) }
  scope :effective_after, ->(date) { where('effective_date >= ?', date) }

  private

  def requires_professional_disclaimer?
    %w[legal medical financial investment].include?(disclaimer_type)
  end
end