class CreateCookiePolicies < ActiveRecord::Migration[8.0]
  def change
    create_table :cookie_policies do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, default: "Cookie Policy"
      t.text :generated_content
      t.string :status
      t.boolean :essential_cookies, default: false
      t.boolean :analytics_cookies, default: false
      t.boolean :marketing_cookies, default: false
      t.boolean :preference_cookies, default: false
      t.boolean :social_media_cookies, default: false
      t.boolean :cookie_banner, default: false
      t.text :third_party_cookies
      t.string :cookie_duration
      t.string :opt_out_method
      t.boolean :cookie_refresh, default: false

      t.timestamps
    end
  end
end
