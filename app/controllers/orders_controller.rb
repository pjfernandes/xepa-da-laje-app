class OrdersController < ApplicationController

  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new
  end

  def show
    @order = Order.find(params[:id])
  end

  # def create
  #   @order = Order.new(product_params)
  #   @order.user = current_user
  #   @order.save
  #   redirect_to root_path
  # end

  def create
    @product = Product.find(params[:product_id])
    @order = Order.new(order_params)
    @order.product = @product
    @order.user = current_user
    if @product.quantity == 0
      redirect_to product_path(@product), notice: 'Product not available.'
    elsif @order.quantity > @product.quantity
      redirect_to product_path(@product), notice: 'Quantity not available.'
    else
      old_product_quantity = @product.quantity
      @product.quantity = old_product_quantity - @order.quantity
      @product.save
      @order.save
      redirect_to product_path(@product), notice: 'Order was successfully created.'
    end
  end

  private
  def order_params
    params.require(:order).permit(:quantity, :product_id)
  end
  # private
  # def order_params
  #   params.require(:order).permit(:name, :unit_price, :quantity, :description)
  # end

end
