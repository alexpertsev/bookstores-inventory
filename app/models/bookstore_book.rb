class BookstoreBook < ApplicationRecord
  belongs_to :bookstore
  belongs_to :book
  has_one :inventory_level, dependent: :destroy

  after_commit :init_inventory_level, on: :create
  after_create_commit -> { broadcast_prepend_later_to self.bookstore, target: self.bookstore }
  after_destroy_commit -> { broadcast_remove_to self.bookstore }

  private

  def init_inventory_level
    self.create_inventory_level!
  end
end