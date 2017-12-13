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
  remove_filter :user_type
end


index do
	column :id
	column :email
	column :name
	column :address
	column :mobile
	actions
end

show do
  attributes_table do
    row "email", :email do |u_email|
      u_email.email
    end
    row "encrypted password", :encrypted_password do |e_pass|
      e_pass.encrypted_password
    end
    row "reset password token", :reset_password_token do |r_pass|
      r_pass.reset_password_token
    end
    row "reset password sent at", :reset_password_sent_at do |r_pass_s|
      r_pass_s.reset_password_sent_at
    end
    row "remember created at", :remember_created_at do |r_cre_at|
      r_cre_at.remember_created_at
    end
    row "current sign in at", :current_sign_in_at do |c_sig_at|
      c_sig_at.current_sign_in_at.strftime("%d/%m/%Y") if c_sig_at.current_sign_in_at.present?
    end
    row "last sign in at", :last_sign_in_at do |l_sig_at|
      l_sig_at.last_sign_in_at.strftime("%d/%m/%Y") if l_sig_at.last_sign_in_at.present?
    end
    row "current sign in ip", :current_sign_in_ip do |c_sig_ip|
      c_sig_ip.current_sign_in_ip
    end
    row "last sign in ip", :last_sign_in_ip do |l_sig_ip|
      l_sig_ip.last_sign_in_ip
    end
    row "name", :name do |n|
      n.name
    end
    row "address", :address do |a|
      a.address
    end
    row "mobile", :mobile do |m|
      m.mobile
    end
    row "confirmation token", :confirmation_token do |con_t|
      con_t.confirmation_token
    end
    row "confirmed at", :confirmed_at do |con_at|
      con_at.confirmed_at.strftime("%d/%m/%Y") if con_at.confirmed_at.present?
    end
    row "confirmation sent at", :confirmation_sent_at do |con_sent_at|
      con_sent_at.confirmation_sent_at.strftime("%d/%m/%Y") if con_sent_at.confirmation_sent_at.present?
    end
    row "company name", :company_name do |com_name|
      com_name.company_name
    end
    row "PAN", :PAN do |p|
      p.accounts.first.PAN
    end
    row "GST", :GST do |g|
      g.accounts.first.GST
    end
  end
end

controller do
    def scoped_collection
      User.where(user_type: false)
    end
end
end
