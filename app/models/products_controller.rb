class ProductsController < ApplicationController
  def index
    @categories = Category.all

    @products = Product.all
    if params[:search].present?
      @products = @products.where("name ILIKE ? OR description ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end

    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    @products = @products.paginate(page: params[:page], per_page: 10)
  end
end
