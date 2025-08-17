class PrivacyPolicy < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :effective_date, presence: true
  validates :data_types_collected, presence: true
  validates :contact_method, presence: true
  validates :user_id, uniqueness: true

  validates :effective_date, comparison: { greater_than_or_equal_to: Date.current }, on: :create

  CONTACT_METHOD_OPTIONS = %w[email phone postal_mail multiple_methods].freeze

  validates :contact_method, inclusion: { in: CONTACT_METHOD_OPTIONS }
  validates :data_retention_period, numericality: { greater_than: 0 }, allow_blank: true

  validates :user_rights_access, inclusion: { in: [true, false] }, if: :gdpr_compliant?
  validates :user_rights_deletion, inclusion: { in: [true, false] }, if: :gdpr_compliant?
  validates :user_rights_portability, inclusion: { in: [true, false] }, if: :gdpr_compliant?

  scope :gdpr_compliant, -> { where(gdpr_compliant: true) }
  scope :ccpa_compliant, -> { where(ccpa_compliant: true) }
  scope :effective_after, ->(date) { where('effective_date >= ?', date) }

  private

  def gdpr_compliant?
    gdpr_compliant == true
  end
end