class Public::HomesController < ApplicationController
    before_action :authenticate_customer!, except: [:top, :about]

  def top
    @genres = Genre.all
    # 最新から４つ
    @items = Item.where(sales_status:"sale").order(created_At: :desc).limit(4)
  end

  def about
  end
end
