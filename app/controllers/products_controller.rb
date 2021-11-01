class ProductsController < ApplicationController
    skip_before_action :authenticate_user!, only: %i[index show]

  def index
    if params[:query].present?
      @products = Product.search_by_city_and_name(params[:query])
    else
      @products = Product.all
    end
  end

  def show
    @product = Product.find(params[:id])
    #@user = User.find(@product.user_id)
    @user = User.find(@product.user_id)
  end

  def new
    @product = Product.new
  end

  # def create
  #   @product = Product.new(product_params)
  #   @product.user = current_user
  #   @product.save
  #   redirect_to root_path
  # end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      redirect_to root_path, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :unit_price, :quantity, :description)
  end

end
