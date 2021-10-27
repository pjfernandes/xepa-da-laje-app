class ProductsController < ApplicationController
    skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @user = User.find(@product.user_id)
  end

end
