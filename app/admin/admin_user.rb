ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

ActiveAdmin.register User do
  config.per_page = 25
end

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at do |admin_user|
        admin_user.current_sign_in_at.strftime("%d/%m/%Y  %H:%M")
    end
    column :sign_in_count
    column :created_at do |admin_user|
        admin_user.created_at.strftime("%d/%m/%Y  %H:%M")
    end
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
