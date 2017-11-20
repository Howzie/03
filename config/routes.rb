  Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # devise_for :admins
  # devise_for :users
   devise_for :users, :controllers => { :registrations => "users/registrations" }
  # devise_for :users, controllers: {
  #   sessions: 'users/sessions'
  # }
  # root to: "dashboards#home"
  # devise_scope :user do
  #   authenticated :user do
  #     root 'dashboards#index', as: :authenticated_root
  #   end

  #   unauthenticated do
  #     root 'dashboards#home', as: :unauthenticated_root
  #   end
  # end

  # resources :dashboards do
  #   post :upload, :on => :collection
  #   post :import, :on => :collection
  # end
  # namespace :admin do
  #   devise_scope :admin do
  #     authenticated :admin do
  #       root 'admin_dashboards#index', as: :authenticated_root
  #     end

  #     unauthenticated do
  #       root 'admin_dashboards#home', as: :unauthenticated_root
  #     end
  #   end
  # end

  devise_scope :user do
    authenticated :user do
      root 'dashboards#index', as: :authenticated_root
    end

    unauthenticated do
      root 'dashboards#home', as: :unauthenticated_root
    end
  end

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

  resources :dashboards do
    post :import, :on => :collection
    get :upload_inventory, :on => :collection
    get :about_us, :on => :collection
    get :faqs, :on => :collection
  end

  resources :items
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  # namespace :admin do
  # # Directs /admin/products/* to Admin::ProductsController
  # # (app/controllers/admin/products_controller.rb)
  # end
end
