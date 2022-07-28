class Public::CustomersController < ApplicationController

def show
  @customer = current_customer
end

def edit
  @customer = current_customer
end

def update
  @customer = current_customer
  if @customer.update(customer_params)
    redirect_to my_page_customers_path(current_customer)
  else
    render :edit
  end
end

def confirm
end

def withdraw
   @customer = current_customer
   # is_deleteカラムに削除フラグを立てる(defaultはfalse)
   @customer.update(is_deleted: true)
   # ログアウトさせる
   reset_session
   flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
   redirect_to root_path
end

  private
  def customer_params
    params.require(:customer).permit(:is_deleted, :last_name, :first_name, :last_name_kana, :first_name_kana, :email, :post_code, :address, :phone_number)
  end

end

