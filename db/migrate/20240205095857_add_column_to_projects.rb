class AddColumnToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :is_active, :boolean, default: true
    add_reference :projects, :client, null: false, foreign_key: true

  end
end
