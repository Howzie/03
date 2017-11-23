ActiveAdmin.register Order do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
actions :all, :except => [:edit]

permit_params :user_id, :merchant_id, :item_id, :item_qty, :delivery_add, :postal_code, :delivery_date, :is_confirm, :is_delivered, :confirm_date, :paid_date, :status, :is_completed
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
index do
	column "User Id", :user_id
	column "Order No", :id
	column :item_id do |item|
		div :class => "item" do
			item_name = Item.find(item.item_id)
			item_name.name if item_name.present?
		end
    end
    column "Item code", :item_id do |item|
    	div :class => "code" do
			item_code = Item.find(item.item_id)
			item_code.code if item_code.present?
		end
    end
	column "Qty", :item_qty
	column :postal_code
	column :delivery_add
	column :delivery_date do |date|
		date.delivery_date.strftime("%d/%m/%Y")
	end
	column "Delivery status", :status do |status|
		# abort status.inspect
		if status.is_delivered == false
			"Pending"
		elsif status.is_completed == true
			"Confirmed"	
		elsif status.is_delivered == true
			"Delivered"
		end
	end
	column "Order date", :created_at do |date|
		date.created_at.strftime("%d/%m/%Y")
	end
	column "Conf date", :confirm_date do |date|
		date.confirm_date.strftime("%d/%m/%Y") if date.confirm_date.present?
	end
	column "Merchant id", :merchant_id
	column "Paid", :paid_date
	actions
end
end
