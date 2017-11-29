ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :name, :address, :mobile, :user_type, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :failed_attempts, :unlock_token, :locked_at
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
ActiveAdmin.register User do
  config.per_page = 25
  remove_filter :accounts
  remove_filter :orders
  remove_filter :encrypted_password
  remove_filter :reset_password_token
  remove_filter :reset_password_sent_at
  remove_filter :remember_created_at
  remove_filter :current_sign_in_at
  remove_filter :last_sign_in_at
  remove_filter :address
  remove_filter :confirmation_token
  remove_filter :confirmed_at
  remove_filter :confirmation_sent_at
  remove_filter :unconfirmed_email
  remove_filter :failed_attempts
  remove_filter :locked_at
  remove_filter :created_at
  remove_filter :updated_at
  remove_filter :company_name
  remove_filter :unlock_token
end


index do
	column :id
	column :email
	column :name
	column :address
	column :mobile
	actions
end

controller do
    def scoped_collection
      User.where(user_type: false)
    end
end
end
