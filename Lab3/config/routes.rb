Rails.application.routes.draw do

  root 'sessions#new'


  get 'logout'     =>   'sessions#destroy'
  get 'login'      =>   'sessions#new'
  get 'sign_up'    =>   'clients#new'
  get 'main'       =>   'sessions#show'

  get 'adminpanel'   =>   'sessions#adminpanel'
  get 'bookpanel'    =>   'sessions#bookpanel'
  get 'bet_actions'  =>   'sessions#bet_actions'

  post 'makebet'    =>   'sessions#makebet'
  post 'signup'     =>   'clients#signup'
  post 'prediction' =>   'sessions#predict'
  post 'endrace'    =>   'sessions#finishBets'


  resources :sessions
  resources :ridings
  resources :clients

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



  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
