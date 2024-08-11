class ProductsController < ApplicationController
  def index
    @categories = Category.all


    if params[:search].present? || params[:category_id].present?
      @products = Product.all
      @products = @products.where("name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
      @products = @products.where(category_id: params[:category_id]) if params[:category_id].present?
    else
      @products = Product.all
    end

    @products = @products.page(params[:page]) # Assuming pagination is used
  end
end
