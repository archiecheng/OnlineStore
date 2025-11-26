class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  helper_method :current_user, :logged_in?, :admin_user?
  before_action :set_cart

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def admin_user?
    logged_in? && current_user.admin?
  end

  def require_login
    redirect_to login_path, alert: "You must be logged in." unless logged_in?
  end

  def require_admin
    redirect_to root_path, alert: "Access denied" unless admin_user?
  end

  private

  def set_cart
    @cart = current_user&.cart
  end
end
