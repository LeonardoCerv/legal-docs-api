class CreatePrivacyPolicies < ActiveRecord::Migration[8.0]
  def change
    create_table :privacy_policies do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, default: "Privacy Policy"
      t.text :generated_content
      t.string :status
      t.boolean :collects_personal_info, default: false
      t.text :data_types
      t.boolean :uses_cookies, default: false
      t.text :third_party_services
      t.boolean :shares_data, default: false
      t.boolean :sells_data, default: false
      t.string :data_retention_period
      t.boolean :gdpr_compliant, default: false
      t.boolean :ccpa_compliant, default: false
      t.boolean :coppa_compliant, default: false
      t.boolean :has_children_users, default: false
      t.string :contact_method
      t.boolean :data_protection_officer, default: false
      t.boolean :automated_decision_making, default: false
      t.boolean :cross_border_transfers, default: false

      t.timestamps
    end
  end
end
