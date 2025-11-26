class UpdateCartItemsNullsAndDefault < ActiveRecord::Migration[8.1]
  def change
    change_column_null :cart_items, :cart_id, true
    change_column_null :cart_items, :order_id, true
    change_column_default :cart_items, :quantity, 0
    change_column_null :cart_items, :quantity, false
  end
end
