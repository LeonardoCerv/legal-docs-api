class RemoveDuplicateDocuments < ActiveRecord::Migration[8.0]
  def up
    # Remove duplicate TermsOfService records, keeping the earliest one for each user
    execute <<-SQL
      DELETE FROM terms_of_services 
      WHERE id NOT IN (
        SELECT MIN(id) 
        FROM terms_of_services 
        GROUP BY user_id
      )
    SQL

    # Remove duplicate PrivacyPolicy records, keeping the earliest one for each user
    execute <<-SQL
      DELETE FROM privacy_policies 
      WHERE id NOT IN (
        SELECT MIN(id) 
        FROM privacy_policies 
        GROUP BY user_id
      )
    SQL

    # Remove duplicate CookiePolicy records, keeping the earliest one for each user
    execute <<-SQL
      DELETE FROM cookie_policies 
      WHERE id NOT IN (
        SELECT MIN(id) 
        FROM cookie_policies 
        GROUP BY user_id
      )
    SQL

    # Remove duplicate Disclaimer records, keeping the earliest one for each user
    execute <<-SQL
      DELETE FROM disclaimers 
      WHERE id NOT IN (
        SELECT MIN(id) 
        FROM disclaimers 
        GROUP BY user_id
      )
    SQL

    # Remove duplicate AcceptableUsePolicy records, keeping the earliest one for each user
    execute <<-SQL
      DELETE FROM acceptable_use_policies 
      WHERE id NOT IN (
        SELECT MIN(id) 
        FROM acceptable_use_policies 
        GROUP BY user_id
      )
    SQL
  end

  def down
    # Cannot restore deleted duplicates
    raise ActiveRecord::IrreversibleMigration
  end
end
