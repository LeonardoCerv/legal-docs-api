class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  
  # Legal document relationships
  has_one :organization, dependent: :destroy
  has_many :terms_of_services, dependent: :destroy
  has_many :privacy_policies, dependent: :destroy
  has_many :cookie_policies, dependent: :destroy
  has_many :disclaimers, dependent: :destroy
  has_many :acceptable_use_policies, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  
  # Helper method to get all documents
  def documents
    [
      terms_of_services,
      privacy_policies, 
      cookie_policies,
      disclaimers,
      acceptable_use_policies
    ].flatten
  end
end
