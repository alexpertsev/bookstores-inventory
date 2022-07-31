class CreateInventoryLevels < ActiveRecord::Migration[6.1]
  def change
    create_table :inventory_levels do |t|
      t.references :bookstore_book, null: false, foreign_key: true
      t.integer :stock_level, null: false, default: 0

      t.timestamps
    end
  end
end
