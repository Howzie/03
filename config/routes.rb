  Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  devise_for :users, :controllers => { :registrations => "users/registrations" }
  
  root to: "dashboards#index"

  resources :orders do
    post :upload, :on => :collection
    get :user_order, :on => :member
    get :show_order, :on => :collection
    get :modify_order, on: :collection
    get :my_orders, on: :collection
    get :deliver_order, :on => :member
    get :order_status, :on => :member
  end
  match "make_order", to: "orders#make_order", as: :make_order, via: [:get, :post]

  match '/send_mail', to: 'pages#send_mail', via: 'post'

  resources :dashboards do
    post :import, :on => :collection
    get :upload_inventory, :on => :collection
  end

  resources :items

  resources :pages do
    get :about_us, :on => :collection
    get :faqs, :on => :collection
  end
end
