class ApplicationController < ActionController::Base

  private

  def current_cart

    current_cart = Cart.find_by(id: session[:cart_id])

    current_cart = Cart.create unless current_cart

    session[:cart_id] = current_cart.id

    current_cart
  end

end
