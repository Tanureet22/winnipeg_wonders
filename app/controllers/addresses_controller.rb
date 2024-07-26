# app/controllers/addresses_controller.rb
class AddressesController < ApplicationController
  before_action :authenticate_user!

  def new
    @address = current_user.build_address
  end

  def create
    @address = current_user.build_address(address_params)
    if @address.save
      redirect_to root_path, notice: 'Address added successfully'
    else
      render :new
    end
  end

  private

  def address_params
    params.require(:address).permit(:street, :city, :postal_code, :province_id)
  end
end
