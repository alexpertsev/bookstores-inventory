class BookstoreBook < ApplicationRecord
  belongs_to :bookstore
  belongs_to :book
  has_one :inventory_level, dependent: :destroy
  
  after_commit :init_inventory_level, on: :create

  private

  def init_inventory_level
    self.create_inventory_level!
  end
end