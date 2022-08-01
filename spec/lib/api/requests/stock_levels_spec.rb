require 'rails_helper'

describe 'Fetch, Create, Update Stock Levels API', type: :request do
  fixtures :bookstores
  fixtures :books

  let(:bookstore_book) { FactoryBot.create(:bookstore_book, { book_id: books(:"0887307280"), 
                                                              bookstore_id: bookstores(:indigo) })}
  let(:inventory_level) { FactoryBot.create(:inventory_level, { bookstore_book_id: bookstore_book.id, 
                                                                stock_level: 10 }) }                                                          

  describe 'GET /bookstore_stock_level' do
          
    it 'should return books stock levels for specific bookstore' do
      get '/api/bookstore_stock_level', params: { bookstore_id: bookstores(:indigo).id }
      
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body).deep_symbolize_keys
      expect(result[:result].first[:book_id]).to eq(books(:"0887307280").id)
    end  
    
    it 'should report an error if bookstore_id is missing' do
      get '/api/bookstore_stock_level'
      expect(response).to have_http_status(:unprocessable_entity)
    end  
      
    it 'should return not_found if bookstore_id is invalid' do
      get '/api/bookstore_stock_level', params: { bookstore_id: 1 }
      expect(response).to have_http_status(:not_found)
    end  
  end
  
  describe 'PATCH /bookstore_stock_level' do
    it 'should be able to add to stock' do
      patch '/api/bookstore_stock_level', params: { bookstore_stock_level: { 
                                                      bookstore_id: bookstores(:indigo).id, 
                                                      book_id: books(:"0887307280").id, 
                                                      operation: 'add',
                                                      stock_level: 5 
                                                    } 
                                                  }, as: :json
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body).deep_symbolize_keys 
      expect(result[:result][:stock_level]).to eq(15)                                         
    end  
    
    it 'should be able to remove from stock' do
      patch '/api/bookstore_stock_level', params: { bookstore_stock_level: { 
                                                      bookstore_id: bookstores(:indigo).id, 
                                                      book_id: books(:"0887307280").id, 
                                                      operation: 'remove',
                                                      stock_level: 3 
                                                    } 
                                                  }, as: :json                                            
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body).deep_symbolize_keys 
      expect(result[:result][:stock_level]).to eq(7)                                         
    end 
    
    it 'should report an error when trying to remove more than available' do
      patch '/api/bookstore_stock_level', params: { bookstore_stock_level: { 
                                                      bookstore_id: bookstores(:indigo).id, 
                                                      book_id: books(:"0887307280").id, 
                                                      operation: 'remove',
                                                      stock_level: 11
                                                    } 
                                                  }, as: :json                                            
      expect(response).to have_http_status(:bad_request)                                    
    end 
  end
  
  describe 'POST /bookstore_stock_level' do
    it 'should be able to create inventory for existing book in catalog for specific bookstore' do
      post '/api/bookstore_stock_level', params: { bookstore_stock_level: { 
                                                    bookstore_id: bookstores(:indigo).id, 
                                                    book_id: books(8098739634).id, 
                                                    stock_level: 20 
                                                   } 
                                                 }, as: :json
                                                 
       expect(response).to have_http_status(:ok) 
       result = JSON.parse(response.body).deep_symbolize_keys 
       expect(result[:result][:stock_level]).to eq(20)                                           
    end    
  end 
end  