class Public::CustomersController < ApplicationController

def new

end

def confirm
end

def withdraw
end

  private
  def customer_params
    params.require(:customer).permit(:name)
  end

end

