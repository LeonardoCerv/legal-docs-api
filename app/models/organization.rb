class Organization < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
