class CreateAcceptableUsePolicies < ActiveRecord::Migration[8.0]
  def change
    create_table :acceptable_use_policies do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, default: "Acceptable Use Policy"
      t.text :generated_content
      t.string :status
      t.boolean :has_user_content, default: false
      t.text :content_restrictions
      t.boolean :has_reporting, default: false
      t.text :enforcement_actions
      t.boolean :has_appeals_process, default: false
      t.string :monitoring_policy
      t.boolean :automated_moderation, default: false
      t.boolean :user_responsibility, default: false
      t.boolean :bandwidth_limits, default: false
      t.boolean :commercial_use_allowed, default: false
      t.boolean :resale_prohibited, default: false

      t.timestamps
    end
  end
end
