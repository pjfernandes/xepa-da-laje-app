class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    if params[:query].present?
      @products = Product.search_by_city_and_name(params[:query])
    else
      @products = Product.all
    end

      #  sql_query = " \
      #   movies.title ILIKE :query \
      #   OR movies.synopsis ILIKE :query \
      #   OR directors.first_name ILIKE :query \
      #   OR directors.last_name ILIKE :query \
      # "
      # @users = User.joins(:product).where(sql_query, query: "%#{params[:query]}%")

      #@users = @products.map { |product| product.user }.uniq
      #@users = User.joins(:products).where(products:{"name ILIKE ?", "%#{params[:query]}%"})
      #@users = User.joins("SELECT * FROM users JOIN products ON users.id = products.user_id;")
      @users =  User.where(id: @products.map(&:user_id))

      @markers = @users.geocoded.map do |user|
        {
          lat: user.latitude,
          lng: user.longitude,
          info_window: render_to_string(partial: "info_window", locals: { user: user })
        }
      end
  end

  def show
    @product = Product.find(params[:id])
    @user = User.find(@product.user_id)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    address = "#{current_user.address}, #{current_user.city}"
    new_coordinates = Geocoder.coordinates(address)

    unless new_coordinates.nil?
      # current_user.longitude =
      # current_user.latitude = new_coordinates[0]
      # current_user.save
      user = User.find(current_user.id)
      user.latitude = new_coordinates[0]
      user.longitude = new_coordinates[1]
      user.save!
    else
      new_coordinates = Geocoder.coordinates(current_user.city)
      user = User.find(current_user.id)
      user.latitude = new_coordinates[0]
      user.longitude = new_coordinates[1]
      user.save!
    end

    @product.user = current_user
    if @product.save
      redirect_to root_path, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :unit_price, :quantity, :description, :photo)
  end

end
