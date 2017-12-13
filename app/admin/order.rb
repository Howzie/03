ActiveAdmin.register Order do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
actions :all, :except => [:edit, :destroy]

permit_params :user_id, :merchant_id, :item_id, :item_qty, :delivery_add, :postal_code, :delivery_date, :is_confirm, :is_delivered, :confirm_date, :paid_date, :status, :is_completed
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
ActiveAdmin.register Order do
  config.per_page = 25
  remove_filter :delivery_add
  remove_filter :is_confirm
  remove_filter :status
  remove_filter :created_at
  remove_filter :updated_at
end

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
	column "Postcode", :postal_code
	column :delivery_add
	column "Del date", :delivery_date do |date|
		date.delivery_date.strftime("%d/%m/%Y")
	end
	column "Del status", :status do |status|
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
	column "M id", :merchant_id
	column "Paid", :paid_date
	actions
end

show do
	attributes_table do
		row "user id", :user_id do |u_id|
			u_id.user_id
		end
		row "merchant id", :merchant_id do |m_id|
			m_id.merchant_id
		end
		row "item", :item_id do |i_id|
			i_id.item.name
		end
		row "item qty", :item_qty do |i_qty|
			i_qty.item_qty
		end
		row "delivery add", :delivery_add do |d_add|
			d_add.delivery_add
		end
		row "postal code", :postal_code do |p_code|
			p_code.postal_code
		end
		row "delivery date", :delivery_date do |d_date|
			d_date.delivery_date.strftime("%d/%m/%Y")
		end
		row "is confirm", :is_confirm do |i_conf|
			i_conf.is_confirm
		end
		row "is delivered", :is_delivered do |i_del|
			i_del.is_delivered
		end
		row "is completed", :is_completed do |i_del|
			i_del.is_completed
		end
		row "created at", :created_at do |c_dat|
			c_dat.created_at.strftime("%d/%m/%Y")
		end
		row "updated at", :updated_at do |u_dat|
			u_dat.updated_at.strftime("%d/%m/%Y")
		end
		row "confirm date", :confirm_date do |c_dat|
			c_dat.confirm_date.strftime("%d/%m/%Y") if c_dat.confirm_date.present?
		end
		row "paid date", :paid_date do |p_dat|
			p_dat.paid_date.strftime("%d/%m/%Y") if p_dat.paid_date.present?
		end
	end
end

end
