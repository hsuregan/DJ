Rails.application.routes.draw do

  resources :sessions
  resources :users
  resources :articles
  resources :news
  resources :requests
  resources :concert_reviews #do i need this?

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  get 'login', to: 'sessions#new', as: 'login'

  get 'signup', to: 'users#new', as: 'signup'

  get 'reviews', to: 'articles#reviews', as: 'reviews'

  get 'critics', to: 'articles#index', as: 'critics'

  get 'autocomplete_artist', to: 'articles#autocomplete_artist', as: 'autocomplete_artist'

  get 'autocomplete_album', to: 'articles#autocomplete_album', as: 'autocomplete_album'

  get 'articles/:id/approve' => 'articles#approve', as: :articles_approve

  get 'articles/:id/deny' => 'articles#deny', as: :articles_deny

  get 'concert_reviews/:id/approve' => 'concert_reviews#approve', as: :concert_reviews_approve
    get 'concert_reviews/:id/deny' => 'concert_reviews#deny', as: :concert_reviews_deny


  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalo#ggpurchase', as: :purchase

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
