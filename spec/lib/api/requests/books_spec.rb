require 'rails_helper'

describe 'List all books API', type: :request do
  fixtures :bookstores
  fixtures :books
 
  let(:bookstore_book) { FactoryBot.create(:bookstore_book, { book_id: books(:"0887307280"), 
                                                              bookstore_id: bookstores(:indigo) })}
  let(:inventory_level) { FactoryBot.create(:inventory_level, { bookstore_book_id: bookstore_book.id, 
                                                                stock_level: 10 }) }
  
  describe 'GET /books' do
    
    it 'should list all books' do
      get '/api/books'
      expect(response).to have_http_status(:ok)
    end  
  end  
  
  describe 'DELETE /books' do
    it 'should destroy a book' do
      all_count = BookstoreBook.all.count
      this_book_count = BookstoreBook.where(book_id: books(:"0887307280").id).count
      
      delete "/api/books/#{books(:"0887307280").id}"
      expect(response).to have_http_status(:ok)
      expect(BookstoreBook.all.count).to eq(all_count - this_book_count)
      expect(InventoryLevel.all.count).to eq(all_count - this_book_count)
    end  
  end  
  
  
end  