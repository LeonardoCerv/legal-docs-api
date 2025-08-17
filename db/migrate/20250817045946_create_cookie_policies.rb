class CreateCookiePolicies < ActiveRecord::Migration[8.0]
  def change
    create_table :cookie_policies do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
