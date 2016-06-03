class ChargesController < ApplicationController
    def new
end

def create
  # Amount in cents
  @amount = 500
=begin
  customer = Stripe::Customer.create(
    :email => params[:stripeEmail],
    :source  => params[:stripeToken]
  )
=end
   customer= Stripe::Customer.create(
    :email => params[:stripeEmail],
    :source  => params[:stripeToken],
    :plan => "day-plan"
  )
=begin  
  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount,
    :description => 'Rails Stripe customer',
    :currency    => 'eur'
  )
=end  

rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to new_charge_path
end
end
