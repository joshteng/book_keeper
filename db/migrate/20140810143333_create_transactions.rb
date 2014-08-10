class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :entry, null: false
      t.string :item, null: false
      t.text :notes
      t.decimal :amount, :precision => 8, :scale => 2, null: false
      t.string :currency, null: false
      t.date :transacted_at, null: false
      t.string :transaction_method, null: false
      t.string :receipt_url
      t.integer :user_id
      t.uuid :book_id

      t.timestamps
    end
    add_index :transactions, :entry
    add_index :transactions, :transaction_method
    add_index :transactions, :book_id
  end
end
