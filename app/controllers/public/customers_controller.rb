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
      redirect_to customers_path
    else
      render :edit
    end
    
  end
  
  def quit
    
  end
  
  def out
    @customer = current_customer
    @customer.update(is_active: true)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(
      :last_name,:first_name,:last_name_kana,:first_name_kana,:email,:postal_code,:address,:telephone_number)
  end
end
