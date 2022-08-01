module Api
  module V1
    class BooksController < ApplicationController
      
      def index
        results = Book.all.as_json
        render_success('Books are listed', results, status: :ok)
      end
      
      def destroy
        Book.find(params[:id]).destroy
        render_success('Book is deleted.', {}, status: :ok)
      end    
    end
  end
end      