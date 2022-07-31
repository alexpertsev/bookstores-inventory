require "application_system_test_case"

class BookstoresTest < ApplicationSystemTestCase
  setup do
    @bookstore = Bookstore.first
  end

  test "Showing a quote" do
    visit bookstores_path
    click_link @bookstore.name

    assert_selector "h1", text: @bookstore.name
  end
end
