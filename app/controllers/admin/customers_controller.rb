class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!, if: :admin_url


  def admin_url
    request.fullpath.include?("/admin")
  end

  def index
   @customers = Customer.all
  end

  def show
   @customer = Customer.find(params[:id])
  end

  def edit
   @customer = Customer.find(params[:id])
  end

  def update
   @customer = Customer.find(params[:id])
   @customer.update(customer_params)
   redirect_to admin_customer_path(@customer)
  end

  private
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :post_code, :address, :email, :phone_number, :is_deleted )
  end
end
