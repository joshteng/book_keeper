class CreateBookUsers < ActiveRecord::Migration
  def change
    create_table :book_users do |t|
      t.uuid :book_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :book_users, [:book_id, :user_id], :unique => true
  end
end
