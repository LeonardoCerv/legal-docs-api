class CreateOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.string :company_name
      t.string :legal_name
      t.string :contact_email
      t.string :website_url
      t.text :address
      t.string :jurisdiction
      t.string :industry
      t.date :founded_date
      
      t.timestamps
    end
  end
end
