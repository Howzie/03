class AddConfirmdateToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :confirm_date, :date
    add_column :orders, :paid_date, :date
  end
end
