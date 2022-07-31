class CreateBookstoreBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookstore_books do |t|
      t.references :bookstore, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :bookstore_books, [:bookstore_id, :book_id], unique: true
  end
end
