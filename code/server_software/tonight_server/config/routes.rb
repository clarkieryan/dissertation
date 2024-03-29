TonightServer::Application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'static#index'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

#Administrator stuff
namespace :admin do |admin|
  
  root 'static#index';

  resources :jobs
  resources :users
  resources :venues
  resources :events

end
  
use_doorkeeper
namespace :api do 
  namespace :v1 do

    #Various functions to get the events
    get 'events' => 'events#index'
    get 'events/:id' => 'events#eventByID'
    get 'venues' => 'venues#index'
    get 'venues/:id' => 'venues#show'
    get 'venues/:id/events' => 'events#eventsByVenue'

    #Registeration
    post '/register' => 'user#register'

    #Currently logged on user details and functions
    get 'user' => 'user#index'
    post 'user' => 'user#update'
    #Users feed of event
    get 'user/feed' => 'user#feed'

    #Lists all of the categories
    get 'categories' =>'categories#index'
    get 'categories/:id' => 'categories#show'
    get 'categories/:id/events' => 'events#eventsByCategory'

    #List events by city
    get '/cities' => 'cities#index'
    get '/cities/:id' => 'cities#show'
    get '/cities/:id/events' => 'events#eventsByCity'

    #2 Main screns 
    get '/cities/:city_id/venues' => 'venues#venuesByCity'
    get '/cities/:city_id/categories' => 'categories#catsByCity'

    # TODO -> Implement
    #Add in the ability to follow events
    get 'user/following' => 'following#index'
    post 'user/follow' => 'following#followEvent'
    post 'user/unfollow' => 'following#unfollowEvent'
  end
end
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