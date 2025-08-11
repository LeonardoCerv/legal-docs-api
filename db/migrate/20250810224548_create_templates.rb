class CreateTemplates < ActiveRecord::Migration[8.0]
  def change
    create_table :templates do |t|
      t.string :title
      t.string :slug
      t.text :body
      t.integer :doc_type
      t.integer :version
      t.boolean :published

      t.timestamps
    end
  end
end
