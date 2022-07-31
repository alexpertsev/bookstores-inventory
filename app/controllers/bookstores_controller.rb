class BookstoresController < ApplicationController
  
  def index
    @bookstores = Bookstore.all
  end
  
  def show
    @bookstore = Bookstore.find(params[:id])
  end    
    
end
