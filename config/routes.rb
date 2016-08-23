Rails.application.routes.draw do
  get 'admin' => 'admin#index'
  get 'admin/review_song/:id' => 'admin#review_song'

  get 'login_popup' => 'session#login_popup'
  post 'login' => 'session#login'
  get 'logout' => 'session#logout'


  get 'profile' => 'users#profile'
  post 'register' => 'users#register'
  post 'users/update' => 'users#update'
  get 'users/upload_pic' => 'users#upload_pic'
  patch 'users/update_pic' => 'users#update_pic'
  get 'users/sm_popup' => 'users#sm_popup'
  post 'users/update_sm' => 'users#update_sm'
  get 'users/show/:id' => 'users#show'

  get 'songs/index'
  post 'songs/top_search' => 'songs#top_search'
  get 'qty' => 'songs#qty'
  get 'audio_upload' => 'songs#audio_upload'
  post 'audio_submit/:id' => 'songs#audio_submit'
  get 'songs/show/:id' => 'songs#show'
  post 'songs/update/:id' => 'songs#update'
  post 'songs/create' => 'songs#create'
  get 'songs/new/:qty' => 'songs#new'
  get '/songs/upload_audio/:id' => 'songs#upload_audio'
  patch 'songs/update_audio/:id' => 'songs#update_audio'
  get '/songs/play_count/:id' => 'songs#play_count'

  get 'new_submit' => 'session#new_submit'
  get 'register' => 'session#register'

  root 'session#index'
  get 'about' => 'session#about'

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
