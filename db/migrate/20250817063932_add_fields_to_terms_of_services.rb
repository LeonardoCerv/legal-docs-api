class AddFieldsToTermsOfServices < ActiveRecord::Migration[8.0]
  def change
    add_column :terms_of_services, :title, :string
    add_column :terms_of_services, :effective_date, :date
    add_column :terms_of_services, :acceptance_required, :boolean
    add_column :terms_of_services, :minimum_age, :integer
    add_column :terms_of_services, :governing_law, :string
    add_column :terms_of_services, :jurisdiction, :string
    add_column :terms_of_services, :dispute_resolution, :string
    add_column :terms_of_services, :user_data_collection, :boolean
    add_column :terms_of_services, :account_termination_notice_days, :integer
    add_column :terms_of_services, :refund_policy, :string
    add_column :terms_of_services, :service_availability, :string
    add_column :terms_of_services, :user_generated_content_policy, :string
  end
end
