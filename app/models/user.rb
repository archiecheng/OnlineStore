class User < ApplicationRecord
  has_one :cart, dependent: :destroy
  has_many :orders
  has_secure_password
  validates :name, presence: true, uniqueness: true

  after_create :create_cart_for_user

  private

  def create_cart_for_user
    create_cart
  end
end
