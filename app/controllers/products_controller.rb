# app/controllers/products_controller.rb
class ProductsController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.all
    @products = @products.where(on_sale: true) if params[:filter] == 'on_sale'
    @products = @products.new_products if params[:filter] == 'new'
    @products = @products.recently_updated if params[:filter] == 'recently_updated'
    @products = @products.page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
    # Logic to display a single product
  end

  def category
    @category = Category.find(params[:id])
    @products = @category.products.page(params[:page])
  end

  def index
    @categories = Category.all
  Rails.logger.debug { "Categories: #{@categories.inspect}" }
    if params[:filter] == 'on_sale'
      @products = Product.where(on_sale: true).page(params[:page]).per(10)
    elsif params[:filter] == 'new'
      @products = Product.where('created_at >= ?', 3.days.ago).page(params[:page]).per(10)
    elsif params[:filter] == 'recently_updated'
      @products = Product.where('updated_at >= ?', 3.days.ago).page(params[:page]).per(10)
    else
      @products = Product.all.page(params[:page]).per(10)
    end
  end

  def search
    @products = Product.all
    if params[:keyword].present?
      @products = @products.where('name LIKE ? OR description LIKE ?', "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end
    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end
    @products = @products.page(params[:page])
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "Product created successfully!"
      redirect_to @product
    else
      flash.now[:error] = "There was an error creating the product."
      render :new
    end
  end

end
