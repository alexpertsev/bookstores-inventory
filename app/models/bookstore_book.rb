class BookstoreBook < ApplicationRecord
  belongs_to :bookstore
  belongs_to :book
  has_one :inventory_level, dependent: :destroy
  
  #TODO: create Inventory Level with stock level 0 every time this
  # record is created...Because update inventory / add / remove should work
  # with existing stock level unless we would like to check for null...
end