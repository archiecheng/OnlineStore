class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(name: params[:name])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      pending_order = user.orders.find_by(status: "pending")

      if pending_order
        redirect_to new_order_path(id: pending_order.id), notice: "You have a pending order to complete."
      else
        redirect_to root_path, notice: "Welcome back, #{user.name}!"
      end
    else
      flash[:alert] = "Invalid username or password."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You have logged out successfully."
  end
end
