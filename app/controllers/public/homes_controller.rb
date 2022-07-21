class Public::HomesController < ApplicationController

  def top
    @orders = Order.all
  end

  def about
  end
end
