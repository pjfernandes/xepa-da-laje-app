class OrdersController < ApplicationController



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
    @order = Order.new
    @order.product = @product
    @order.user = current_user
    @order.save
    redirect_to product_order_path(@product), notice: 'Order was successfully created.'
  end

  # private
  # def order_params
  #   params.require(:order).permit(:name, :unit_price, :quantity, :description)
  # end

end
