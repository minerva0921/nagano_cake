class SessionsController < ApplicationController
  before_action :reject_customer, only: [:create]

  protected

  def reject_customer
    @customer = Customer.find_by(email: params[:customer][:email].downcase)
    if @customer
      if (@customer.valid_password?(params[:customer][:password]) && (@customer.active_for_authentication? == false))
        flash[:alert] = "このアカウントは退会済みです。"
        redirect_to new_customer_session_path
      end
    else
      flash[:alert] = "必須項目を入力してください"
    end
  end
end
