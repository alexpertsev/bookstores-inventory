# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_07_31_183437) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string "author", null: false
    t.string "title", null: false
    t.string "isbn", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bookstore_books", force: :cascade do |t|
    t.bigint "bookstore_id", null: false
    t.bigint "book_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_bookstore_books_on_book_id"
    t.index ["bookstore_id", "book_id"], name: "index_bookstore_books_on_bookstore_id_and_book_id", unique: true
    t.index ["bookstore_id"], name: "index_bookstore_books_on_bookstore_id"
  end

  create_table "bookstores", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "inventory_levels", force: :cascade do |t|
    t.bigint "bookstore_book_id", null: false
    t.integer "stock_level", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bookstore_book_id"], name: "index_inventory_levels_on_bookstore_book_id"
  end

  add_foreign_key "bookstore_books", "books"
  add_foreign_key "bookstore_books", "bookstores"
  add_foreign_key "inventory_levels", "bookstore_books"
end
