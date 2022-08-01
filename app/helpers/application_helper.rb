module ApplicationHelper

  def display_stock_level(stock_level)
    return stock_level if stock_level > 0

    tag.div class: "bookstore-book__title__out_of_stock" do
      "Out of Stock!"
    end
  end
end
