class CookiePolicy < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :effective_date, presence: true
  validates :user_id, uniqueness: true

  validates :effective_date, comparison: { greater_than_or_equal_to: Date.current }, on: :create

  COOKIE_BANNER_TYPE_OPTIONS = %w[simple_notice opt_in opt_out granular_consent].freeze

  validates :cookie_banner_type, inclusion: { in: COOKIE_BANNER_TYPE_OPTIONS }, allow_blank: true

  validates :cookie_consent_required, inclusion: { in: [true, false] }, if: :marketing_cookies?

  scope :requires_consent, -> { where(cookie_consent_required: true) }
  scope :effective_after, ->(date) { where('effective_date >= ?', date) }

  private

  def marketing_cookies?
    marketing_cookies == true
  end
end