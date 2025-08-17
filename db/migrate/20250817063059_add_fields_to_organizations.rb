class AddFieldsToOrganizations < ActiveRecord::Migration[8.0]
  def change
    add_column :organizations, :name, :string
    add_column :organizations, :legal_name, :string
    add_column :organizations, :industry, :string
    add_column :organizations, :business_type, :string
    add_column :organizations, :address, :text
    add_column :organizations, :city, :string
    add_column :organizations, :state, :string
    add_column :organizations, :country, :string
    add_column :organizations, :postal_code, :string
    add_column :organizations, :phone, :string
    add_column :organizations, :email, :string
    add_column :organizations, :website, :string
    add_column :organizations, :registration_number, :string
    add_column :organizations, :tax_id, :string
    add_column :organizations, :dpo_name, :string
    add_column :organizations, :dpo_email, :string
    add_column :organizations, :gdpr_representative, :text
    add_column :organizations, :data_retention_period, :integer
    
    add_index :organizations, :user_id, unique: true
  end
end
