class ShopsController < ApplicationController

  def index
    @shops = Shop.all
  end

  def show
    @items = Shop.find(params[:id]).items
    @total = 2.5
  end

end
