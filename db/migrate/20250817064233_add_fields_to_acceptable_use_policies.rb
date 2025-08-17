class AddFieldsToAcceptableUsePolicies < ActiveRecord::Migration[8.0]
  def change
    add_column :acceptable_use_policies, :title, :string
    add_column :acceptable_use_policies, :effective_date, :date
    add_column :acceptable_use_policies, :prohibited_content, :text
    add_column :acceptable_use_policies, :prohibited_activities, :text
    add_column :acceptable_use_policies, :user_responsibilities, :text
    add_column :acceptable_use_policies, :enforcement_actions, :text
    add_column :acceptable_use_policies, :reporting_violations, :text
    add_column :acceptable_use_policies, :content_moderation, :boolean
    add_column :acceptable_use_policies, :age_restrictions, :boolean
    add_column :acceptable_use_policies, :commercial_use_allowed, :boolean
  end
end
