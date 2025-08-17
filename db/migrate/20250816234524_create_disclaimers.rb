class CreateDisclaimers < ActiveRecord::Migration[8.0]
  def change
    create_table :disclaimers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, default: "Disclaimer"
      t.text :generated_content
      t.string :status
      t.string :service_type
      t.boolean :provides_advice, default: false
      t.string :advice_type
      t.boolean :has_affiliates, default: false
      t.boolean :liability_limitation, default: false
      t.boolean :warranty_disclaimer, default: false
      t.boolean :accuracy_disclaimer, default: false
      t.boolean :third_party_links, default: false
      t.boolean :investment_disclaimer, default: false
      t.boolean :health_disclaimer, default: false
      t.boolean :educational_only, default: false

      t.timestamps
    end
  end
end
