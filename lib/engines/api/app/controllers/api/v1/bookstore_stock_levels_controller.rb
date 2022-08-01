module Api
  module V1
    class BookstoreStockLevelsController < ApplicationController
      
      def show
        results = BookstoreStockLevel.fetch(params.require(:bookstore_id))
        render_success('Stock levels are listed', results, status: :ok)
      end 
      
      def update
         stock_level = BookstoreStockLevel.new(stock_level_params)
         result = stock_level.update
         
         if result
           render_success('Stock level is updated', result, status: :ok)
         else   
           render_failure('Could not update stock level', stock_level.formatted_errors, status: :bad_request)
         end
      end  
      
      def create
        stock_level = BookstoreStockLevel.new(stock_level_params)
        result = stock_level.create
        
        if result
          render_success('Stock level is updated', result, status: :ok)
        else   
          render_failure('Could not update stock level', stock_level.formatted_errors, status: :bad_request)
        end  
      end  
      
      private
      
      def stock_level_params
        params.require(:bookstore_stock_level).permit(:bookstore_id, :book_id, :stock_level, :operation)
      end

    end
  end
end      