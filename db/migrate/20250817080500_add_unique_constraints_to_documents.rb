class AddUniqueConstraintsToDocuments < ActiveRecord::Migration[8.0]
  def change
    remove_index :terms_of_services, :user_id if index_exists?(:terms_of_services, :user_id)
    add_index :terms_of_services, :user_id, unique: true

    remove_index :privacy_policies, :user_id if index_exists?(:privacy_policies, :user_id)
    add_index :privacy_policies, :user_id, unique: true

    remove_index :cookie_policies, :user_id if index_exists?(:cookie_policies, :user_id)
    add_index :cookie_policies, :user_id, unique: true

    remove_index :disclaimers, :user_id if index_exists?(:disclaimers, :user_id)
    add_index :disclaimers, :user_id, unique: true

    remove_index :acceptable_use_policies, :user_id if index_exists?(:acceptable_use_policies, :user_id)
    add_index :acceptable_use_policies, :user_id, unique: true
  end
end
