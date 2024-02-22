class AddSlugToWorkreports < ActiveRecord::Migration[7.1]
  def change
    add_column :workreports, :slug, :string
    add_index :workreports, :slug, unique: true
  end
end
