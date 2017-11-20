class AddGstToItems < ActiveRecord::Migration
  def change
    add_column :items, :gst, :decimal
  end
end
