class Book < ApplicationRecord
  has_many :bookstore_books, dependent: :destroy
  has_many :bookstores, through: :bookstore_books
  
  validates :author, :title, :isbn, presence: true
  
end
