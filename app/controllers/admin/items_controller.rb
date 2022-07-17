class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to item_path
    end
  end


  private
  def item_params
    params.require(:book).permit(:title, :body)
  end
end
