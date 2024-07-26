# app/controllers/carts_controller.rb
class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_user.cart || current_user.create_cart
  end

  def update
    @cart = current_user.cart
    @cart_item = @cart.cart_items.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_path, notice: 'Cart updated successfully'
    else
      render :show
    end
  end

  def destroy
    @cart = current_user.cart
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path, notice: 'Item removed successfully'
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
