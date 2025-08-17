class CreateTermsOfServices < ActiveRecord::Migration[8.0]
  def change
    create_table :terms_of_services do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, default: "Terms of Service"
      t.text :generated_content
      t.boolean :has_user_accounts, default: false
      t.boolean :accepts_payments, default: false
      t.string :payment_processor
      t.boolean :has_subscription, default: false
      t.string :cancellation_policy
      t.boolean :has_user_content, default: false
      t.boolean :content_moderation, default: false
      t.integer :age_restriction
      t.boolean :has_api, default: false
      t.string :dispute_resolution
      t.string :liability_cap
      t.string :termination_notice

      t.timestamps
    end
  end
end
