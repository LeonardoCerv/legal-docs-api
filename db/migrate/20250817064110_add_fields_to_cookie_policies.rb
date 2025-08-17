class AddFieldsToCookiePolicies < ActiveRecord::Migration[8.0]
  def change
    add_column :cookie_policies, :title, :string
    add_column :cookie_policies, :effective_date, :date
    add_column :cookie_policies, :essential_cookies, :boolean
    add_column :cookie_policies, :analytics_cookies, :boolean
    add_column :cookie_policies, :marketing_cookies, :boolean
    add_column :cookie_policies, :preference_cookies, :boolean
    add_column :cookie_policies, :third_party_cookies, :boolean
    add_column :cookie_policies, :cookie_consent_required, :boolean
    add_column :cookie_policies, :cookie_banner_type, :string
    add_column :cookie_policies, :retention_periods, :text
    add_column :cookie_policies, :opt_out_methods, :text
  end
end
