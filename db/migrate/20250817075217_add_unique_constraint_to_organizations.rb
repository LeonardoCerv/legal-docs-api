class AddUniqueConstraintToOrganizations < ActiveRecord::Migration[8.0]
  def change
    remove_index :organizations, :user_id if index_exists?(:organizations, :user_id)
    add_index :organizations, :user_id, unique: true
  end
end
