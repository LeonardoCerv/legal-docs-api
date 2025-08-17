class AddFieldsToPrivacyPolicies < ActiveRecord::Migration[8.0]
  def change
    add_column :privacy_policies, :title, :string
    add_column :privacy_policies, :effective_date, :date
    add_column :privacy_policies, :data_types_collected, :text
    add_column :privacy_policies, :cookies_used, :boolean
    add_column :privacy_policies, :third_party_sharing, :boolean
    add_column :privacy_policies, :international_transfers, :boolean
    add_column :privacy_policies, :user_rights_access, :boolean
    add_column :privacy_policies, :user_rights_deletion, :boolean
    add_column :privacy_policies, :user_rights_portability, :boolean
    add_column :privacy_policies, :data_retention_period, :integer
    add_column :privacy_policies, :contact_method, :string
    add_column :privacy_policies, :gdpr_compliant, :boolean
    add_column :privacy_policies, :ccpa_compliant, :boolean
  end
end
