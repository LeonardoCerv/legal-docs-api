class AddFieldsToDisclaimers < ActiveRecord::Migration[8.0]
  def change
    add_column :disclaimers, :title, :string
    add_column :disclaimers, :effective_date, :date
    add_column :disclaimers, :disclaimer_type, :string
    add_column :disclaimers, :liability_limitation, :boolean
    add_column :disclaimers, :warranty_disclaimer, :boolean
    add_column :disclaimers, :accuracy_disclaimer, :boolean
    add_column :disclaimers, :external_links_disclaimer, :boolean
    add_column :disclaimers, :professional_advice_disclaimer, :boolean
  end
end
