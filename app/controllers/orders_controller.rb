# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  def create
    @order = current_user.orders.new(order_params)
    @order.total_amount = calculate_total_amount(@order)
    @order.tax_amount = calculate_tax_amount(@order)

    if @order.save
      charge = Stripe::Charge.create({
        amount: (@order.total_amount * 100).to_i,
        currency: 'cad',
        description: 'Order Payment',
        source: params[:stripeToken]
      })

      if charge.paid
        @order.update(status: 'paid')
        current_user.cart.cart_items.destroy_all
        redirect_to @order, notice: 'Order placed successfully'
      else
        @order.destroy
        redirect_to new_order_path, alert: 'Payment failed. Please try again.'
      end
    else
      render :new
    end
  end
end
