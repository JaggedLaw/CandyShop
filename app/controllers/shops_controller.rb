class ShopsController < ApplicationController

  def index
    @shops = Shop.all
  end

  def show
    @total = 0
    @items = Shop.find(params[:id]).items
    @items.each do |item|
      @total += item.price
    end
    @total = 2.5
    binding.pry
  end

end
