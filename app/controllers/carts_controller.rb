class CartsController < ApplicationController
  before_action :require_login
  before_action :set_cart, only: %i[show add_product]

  def show
    @cart_items = @cart.cart_items.includes(:product)
  end

  def add_product
    product = Product.find(params[:product_id])
    cart_item = @cart.cart_items.find_or_initialize_by(product: product)
    cart_item.quantity += 1

    if cart_item.save
      redirect_to cart_path(@cart), notice: "Product added to cart!"
    else
      redirect_to products_path, alert: "Could not add product to cart."
    end
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end
end
