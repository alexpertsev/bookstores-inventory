FactoryBot.define do
  factory :book do 
    author { 'John Doe' }
    title { 'Test Title' }
    isbn { '1234567890' }
  end

  factory :bookstore do
    name { 'Indigo' }
  end

  factory :bookstore_book do 
    association :book
    association :bookstore
  end

  factory :inventory_level do |i|
    association :bookstore_book
    stock_level { 10 }
  end
end