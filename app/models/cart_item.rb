class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart, optional: true
  belongs_to :order, optional: true
  validates :quantity, numericality: { greater_than: 0 }
end
