ActiveAdmin.register Order do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
actions :all, :except => [:edit]

permit_params :user_id, :merchant_id, :item_id, :item_qty, :delivery_add, :postal_code, :delivery_date, :is_confirm, :is_delivered
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
