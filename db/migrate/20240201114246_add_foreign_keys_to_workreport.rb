class AddForeignKeysToWorkreport < ActiveRecord::Migration[7.1]
  def change
    add_reference :workreports, :user, null: true, foreign_key: true
    add_column :workreports, :projects_id, :string
  end
end
