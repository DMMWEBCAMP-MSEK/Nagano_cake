class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
    # 最新から４つ
    @items = Item.all.order(created_At: :desc).limit(4)
  end

  def about
  end
end
