# Bookstores Inventory

Implementation of stock levels task based on Rails 6.1.6.1 (with esbuild) using Postgres.

## Installing

After clone run `bundle install`.

Then `bin/setup` and `bin/dev` to run the server (localhost:2000).

## API

List of Books:  curl 'http://localhost:2000/api/books'

List of Bookstores: curl 'http://localhost:2000/api/bookstores'

For specific bookstore:

- Fetch stock level:
  - Required Parameters: `bookstore_id`
  - Example: `curl 'http://localhost:2000/api/bookstore_stock_level?bookstore_id=<some_id>'`
- Update stock level:
  - Required Parameters: `bookstore_id`, `book_id`, `stock_level`, `operation`
  - Valid `operation` values are either 'add' or 'remove'
  - Example `curl -X PATCH -d '{ "bookstore_id": 1019750225, "book_id": 1038543781, "stock_level": 5, "operation": "add"}' -H "Content-Type: application/json" 'http://localhost:2000/api/bookstore_stock_level'`
- Create stock level:
  - Required Parameters: `bookstore_id`, `book_id`, `stock_level`
  - Example `curl -X POST -d '{ "bookstore_id": 1019750225, "book_id": 1038543781, "stock_level": 5}' -H "Content-Type: application/json" 'http://localhost:2000/api/bookstore_stock_level'`

Deleting a book: `curl -X DELETE http://localhost:2000/api/books/:id -H "Accept: application/json"`

Stock levels for specific bookstore are updated on the page using Turbo Streams.


