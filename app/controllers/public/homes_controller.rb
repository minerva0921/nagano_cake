class Public::HomesController < ApplicationController
  def top
    @items = Item.all.order(created_at: :asc)
    @genres = Genre.all
  end
  
  def about
  end
end
