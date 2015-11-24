require 'test_helper'

class GuestSeesShopsTest < ActionDispatch::IntegrationTest

  test 'guest can see a list of shops' do
    # Feature #1:
    # As a guest, I can visit '/shops' and see a list of all shops in the database.
    # Each shop should be link to the shop's show page.
    # A shop should have a name.
    Shop.create(name: 'Candy Shoppe')
    visit '/shops'

    assert page.has_content?('Candy Shoppe')
    click_link('Candy Shoppe')
    assert '/shops/:id', current_path
  end


  test 'guest can view shops page and see a list of items in shop' do
    shop1 = Shop.create(name: 'Candy Shoppe')
    shop1.items.create(name: 'skittles', description: 'fruity', price: 1)
    shop1.items.create(name: 'snickers', description: 'chocolaty', price: 1.5)
    shop2 = Shop.create(name: 'Chocolate City')
    shop2.items.create(name: 'butterfinger', description: 'toffee', price: 1.25)

    # Feature #2:
    # As a guest, I can visit '/shops/:id' and see the shop's name along with items that belong to that specific shop.
    # Each item should be a link to the item's show page.
    visit '/shops'

    assert page.has_content?('Candy Shoppe')
    click_link('Candy Shoppe')
    assert '/shops/:id', current_path

    assert page.has_content?('skittles')
    assert page.has_content?('snickers')
    refute page.has_content?('butterfinger')
    # I should not see items that belong to a different shop.
    # At the top of the page, I should see the total potential revenue for those items (ie - how much would the shop make if they sold every item in the store?).
    assert page.has_content?('2.5')
  end

  test 'guest can view items show page and see name description and price' do
    Item.create(name: 'skittles', description: 'fruity', price: 1)

    visit '/items'
    click_link('skittles')

    assert page.has_content?('fruity')
    assert page.has_content?('1')
    assert page.has_content?('0.8')

    # Feature #3:
    # As a guest, I can visit '/items/:id' and see the item's name, description, and retail price.
    # I should also see what the price of the item would be with a 20% discount.
  end

end
