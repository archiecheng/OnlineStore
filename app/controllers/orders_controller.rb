class OrdersController < ApplicationController
  before_action :require_login
  before_action :set_order, only: %i[show update]

  def index
    @orders = admin_user? ? Order.all : current_user.orders
  end

  def show; end

  def new
    @order = Order.find_by(id: params[:id])
  end

  def create
    cart = current_user.cart || current_user.create_cart
    total_price = cart.cart_items.includes(:product).sum { |item| item.product.price.to_d * item.quantity }
    @order = Order.create(user: current_user, total_price: total_price, status: "pending")
    cart.cart_items.update_all(cart_id: nil, order_id: @order.id)

    if @order.persisted?
      redirect_to new_order_path(id: @order.id), notice: "Order was successfully created."
    else
      redirect_to cart_path(cart), alert: "Could not create order."
    end
  end

  def update
    if @order.update(status: "placed")
      redirect_to order_path(@order), notice: "Order was successfully updated."
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:user_id, :total_price, :status)
  end
end
