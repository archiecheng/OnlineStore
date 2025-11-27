class CartItemsController < ApplicationController
  before_action :require_login
  before_action :set_cart_item, only: %i[create show edit update destroy]

  def show; end

  def edit; end

  def create
    @cart_item.quantity += 1
    if @cart_item.save
      redirect_to root_path, notice: "Book was successfully added to cart."
    else
      redirect_to products_path, alert: "Could not add to cart."
    end
  end

  def update
    direction = params[:direction]
    if direction == "increment"
      @cart_item.increment!(:quantity)
      redirect_to cart_path(current_user.cart), notice: "Updated quantity."
    elsif direction == "decrement"
      if @cart_item.quantity > 1
        @cart_item.decrement!(:quantity)
        redirect_to cart_path(current_user.cart), notice: "Updated quantity."
      else
        @cart_item.destroy
        redirect_to cart_path(current_user.cart), notice: "Item removed."
      end
    else
      if @cart_item.update(cart_item_params)
        redirect_to cart_path(@cart_item.cart || current_user.cart), notice: "Cart item was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @cart_item.destroy
    redirect_to cart_path(current_user.cart), status: :see_other, notice: "Cart item was successfully removed."
  end

  private

  def set_cart_item
    @cart = current_user.cart || current_user.create_cart
    if params[:id]
      @cart_item = @cart.cart_items.find(params[:id])
    else
      @cart_item = @cart.cart_items.find_or_initialize_by(product_id: params[:product_id])
    end
  end

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :cart_id, :order_id, :quantity)
  end
end
