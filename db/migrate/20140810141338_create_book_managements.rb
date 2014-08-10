class CreateBookManagements < ActiveRecord::Migration
  def change
    create_table :book_managements do |t|
      t.integer :book_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :book_managements, [:book_id, :user_id], :unique => true
  end
end
