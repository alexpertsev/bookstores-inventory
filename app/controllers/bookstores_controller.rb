class BookstoresController < ApplicationController
  
  def index
    @bookstores = Bookstore.all
  end
  
  def show
    @bookstore = Bookstore.find(params[:id])
    @bookstore_books = @bookstore.bookstore_books.includes(:book, :inventory_level)
  end    
    
end
