class StockLevelUpdateException < StandardError; end

class InventoryLevel < ApplicationRecord
  belongs_to :bookstore_book
  MAX_STOCK = 1000000

  def add_to_stock!(value)
    self.with_lock do
      if self.stock_level + value <= MAX_STOCK
        self.update(stock_level: (self.stock_level += value))
      else
        raise StockLevelUpdateException, "Cannot have more than #{MAX_STOCK} books in stock."
      end
    end
  end

  def remove_from_stock!(value)
    self.with_lock do
      if value < self.stock_level
        self.update(stock_level: (self.stock_level -= value))
      else
        raise StockLevelUpdateException, 'Cannot remove from stock more than it is available.'
      end
    end
  end
end
