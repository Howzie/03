ActiveAdmin.register Item do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :code, :name, :specification, :price, :stock, :delivery_days, :gst
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
ActiveAdmin.register Item do
  config.per_page = 25
  remove_filter :orders
  remove_filter :user_id
  remove_filter :created_at
  remove_filter :updated_at
end

index do
	column :id
	column :code
	column :name
	column :specification
	column :stock
	column :delivery_days
	column :price, :sortable => :price do |item|
		number_to_currency item.price
	end
	column "GST(%)", :gst
	actions
end

end
