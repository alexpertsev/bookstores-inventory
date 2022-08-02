module Api
  class BookstoreStockLevel < Model
    attribute :bookstore_id, type: Integer
    attribute :book_id, type: Integer
    attribute :stock_level, type: Integer
    attribute :operation
    
    validates :bookstore_id, :book_id, presence: true
    validates :stock_level, numericality: { greater_than: 0 }
    
    with_options on: :update do    
      validates :operation, :inclusion => { in: ["add", "remove"], message: 'should be either add or remove.' }
    end  
    
    def self.fetch(bookstore_id)      
      bookstore = Bookstore.find(bookstore_id)
      result = bookstore.bookstore_books.includes(:book, :inventory_level).map do |bookstore_book|
        self.to_json(bookstore_book)  
      end
      result        
    end 
    
    def update
      if valid?(:update)
        inventory_level = BookstoreBook.find_by_bookstore_id_and_book_id!(bookstore_id, book_id)
                                       .inventory_level                             
        begin
          case operation
          when 'add'
            inventory_level.add_to_stock!(stock_level)  
          when 'remove'  
            inventory_level.remove_from_stock!(stock_level)  
          end  
          
          return BookstoreStockLevel.to_json(inventory_level.bookstore_book)
        rescue StockLevelUpdateException => ex
          errors.add(:base, ex.message)  
        end                                 
      end
      
      return false
    end
    
    def create
      if valid?
         book = Book.find(book_id)
         bookstore = Bookstore.find(bookstore_id)
         
         bookstore_book = BookstoreBook.find_by_bookstore_id_and_book_id(bookstore_id, book_id)
         
         begin 
           if bookstore_book.nil?
             bookstore_book = BookstoreBook.create!({ book: book, bookstore: bookstore })
             bookstore_book.inventory_level.add_to_stock!(stock_level)
             return BookstoreStockLevel.to_json(bookstore_book)
           else 
             errors.add(:base, "This bookstore already selling this book. Use update to add to stock.") 
           end
         rescue StockLevelUpdateException => ex
           errors.add(:base, ex.message)    
         end
      end

      return false
    end
    
    def self.to_json(bookstore_book)
      {
        bookstore_id: bookstore_book.bookstore_id,
        book_id: bookstore_book.book_id,
        author: bookstore_book.book.author,
        title: bookstore_book.book.title,
        stock_level: bookstore_book.inventory_level.stock_level
      } 
    end     
  end 
end    