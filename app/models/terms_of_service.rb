class TermsOfService < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :effective_date, presence: true
  validates :governing_law, presence: true
  validates :jurisdiction, presence: true
  validates :user_id, uniqueness: true

  validates :effective_date, comparison: { greater_than_or_equal_to: Date.current }, on: :create

  DISPUTE_RESOLUTION_OPTIONS = %w[litigation arbitration mediation].freeze
  REFUND_POLICY_OPTIONS = %w[no_refunds full_refund_14_days full_refund_30_days partial_refunds custom_policy].freeze
  SERVICE_AVAILABILITY_OPTIONS = %w[best_effort sla_99_percent sla_99_9_percent custom_sla].freeze
  USER_CONTENT_POLICY_OPTIONS = %w[not_allowed allowed_with_moderation allowed_without_moderation].freeze

  validates :dispute_resolution, inclusion: { in: DISPUTE_RESOLUTION_OPTIONS }, allow_blank: true
  validates :refund_policy, inclusion: { in: REFUND_POLICY_OPTIONS }, allow_blank: true
  validates :service_availability, inclusion: { in: SERVICE_AVAILABILITY_OPTIONS }, allow_blank: true
  validates :user_generated_content_policy, inclusion: { in: USER_CONTENT_POLICY_OPTIONS }, allow_blank: true

  validates :minimum_age, numericality: { greater_than: 0, less_than: 100 }, allow_blank: true
  validates :account_termination_notice_days, numericality: { greater_than: 0 }, allow_blank: true

  scope :by_governing_law, ->(law) { where(governing_law: law) }
  scope :effective_after, ->(date) { where('effective_date >= ?', date) }
end