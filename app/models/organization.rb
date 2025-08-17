class Organization < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :legal_name, presence: true
  validates :industry, presence: true
  validates :business_type, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :user_id, uniqueness: true

  validates :website, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }, allow_blank: true
  validates :phone, format: { with: /\A[\+]?[1-9][\d\s\-\(\)]{7,15}\z/ }, allow_blank: true
  validates :data_retention_period, numericality: { greater_than: 0 }, allow_blank: true

  BUSINESS_TYPES = %w[sole_proprietorship partnership llc corporation nonprofit government other].freeze

  validates :business_type, inclusion: { in: BUSINESS_TYPES }


  scope :by_industry, ->(industry) { where(industry: industry) }
  scope :by_country, ->(country) { where(country: country) }
end
