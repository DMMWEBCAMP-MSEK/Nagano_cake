class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable



  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana, presence: true

  validates :email, presence: true
  validates :post_code, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true

  validates :password, presence: true, length: { minimum: 6 }, allow_blank: true
  validates :password_confirmation, presence: true, length: { minimum: 6 }, allow_blank: true

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end


