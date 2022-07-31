class Bookstore < ApplicationRecord
  has_many :bookstore_books, dependent: :destroy
  has_many :books, through: :bookstore_books

  validates :name, presence: true
end
