  class CreateEmailHierarchies < ActiveRecord::Migration[7.1]
    def change
      create_table :email_hierarchies do |t|
        t.references :user, null: false, foreign_key: true
        t.references :to_user, foreign_key: { to_table: :users }
        t.references :cc_user, foreign_key: { to_table: :users }

        t.timestamps
      end
    end
  end
