namespace :db do
  namespace :seed do
    desc "Picks random books for random bookstores and prepares updated bookstore_books.yml"
    task :prepare_bookstore_books => :environment do
      books = YAML.load_file('./test/fixtures/books.yml').to_a
      bookstores = YAML.load_file('./test/fixtures/bookstores.yml').to_a

      books_per_bookstore = {} # bookstore name =>[isbn1, isbn2, ...]
      bookstores.map(&:first).each { |bookstore| books_per_bookstore[bookstore] = [] }

      num_books = books.size
      num_stores = bookstores.size

      for i in 1..100 do
        selected_book = rand(0..num_books - 1)
        selected_store = rand(0..num_stores - 1)
  
        books_per_bookstore[bookstores[selected_store].first] << books[selected_book].first  
      end  
  
      books_per_bookstore.each { |k, v| books_per_bookstore[k] = v.uniq } 

      result = {}
      counter = 1

      books_per_bookstore.each do |bookstore, isbns|
        isbns.each do |isbn|
          result["bks_record#{counter}"] = { "bookstore" => bookstore, "book" => isbn }
          counter += 1
        end  
      end  

      File.open("./test/fixtures/bookstore_books.yml", "w") do |file| 
        file.write(result.to_yaml) 
      end 
      
      # create random inventory levels yml for each bookstore_book record
      inventory_result = {}
      
      for j in 1..counter - 1 do
        inventory_result["il_record#{j}"] = { "bookstore_book" => "bks_record#{j}", 
                                              "stock_level" => rand(0..10)}
      end
      
      File.open("./test/fixtures/inventory_levels.yml", "w") do |file| 
        file.write(inventory_result.to_yaml) 
      end 
    end  
  end
end