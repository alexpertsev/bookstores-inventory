module Api
  module V1
    class BookstoresController < ApplicationController
      
      def index
        results = Bookstore.all.as_json
        render_success('Bookstores are listed', results, status: :ok)
      end  
    end
  end
end 