Rails.application.routes.draw do


  get 'news' => 'news#index'
  get 'news/archive'
  get 'news/read/:id' => 'news#read'

  get 'profile' => 'profile#index'
  get 'profile/update' => 'profile#updateForm'
  post 'profile/update' => 'profile#update'

  get 'orders/show/:id' => 'orders#show'

  get 'cart' => 'cart#index'
  get '/checkout' => 'cart#checkout'

  post '/checkout' => 'cart#checkout_post'
  post 'cart/add'

  get '/' => 'site#index'
  get 'login' => 'site#loginForm'
  post 'login' => 'site#login'

  get 'logout' => 'site#logout'

  get 'catalog' => 'catalog#index'
  get 'catalog/category/:id' => 'catalog#category'
  get 'catalog/product/:id' => 'catalog#product'
  get 'catalog/search'

  get 'about' => 'site#about'
  get 'admin' => 'admin#index'


  resources :reviews
  resources :users
  resources :orders
  resources :products
  resources :posts
  resources :categories



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
end
