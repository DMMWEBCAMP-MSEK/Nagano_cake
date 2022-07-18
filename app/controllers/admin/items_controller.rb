class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item)
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def index
    @items = Item.all
  end


  private
  def item_params
    params.require(:item).permit(:name, :introduction, :genre_id, :price, :sales_status, :image)
  end
end
