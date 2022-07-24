class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!, except: [:show, :index]

def index
   @items = Item.all.page(params[:page]).reverse_order
   @genres = Genre.all
   @items_count = Item.count
end

def show
   @item = Item.find(params[:id])
   @genres = Genre.all
   @cart_item = CartItem.new
end

#ストロングパラメータ削除(publicのitemでは保存しないため)
end
