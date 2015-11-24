class Item < ActiveRecord::Base

  def get_discount(item)
    value = item[:price] * (80)
    value.to_f/100
  end
end
