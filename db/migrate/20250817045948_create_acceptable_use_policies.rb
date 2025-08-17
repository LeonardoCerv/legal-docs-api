class CreateAcceptableUsePolicies < ActiveRecord::Migration[8.0]
  def change
    create_table :acceptable_use_policies do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
