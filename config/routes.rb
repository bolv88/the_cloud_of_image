TheCloudOfImage::Application.routes.draw do

  resources :camera_places
  get "camera_places/add_place_moniter/:camera_place_id" => "camera_places#add_place_moniter", :as => 'add_place_moniter'


  resources :cameras
  get "cameras/show_by_place/:camera_place_id" => "cameras#show_by_place", :as => "show_by_place"


  post "group_api/index"
  post "api_user/index"
  post "api_moniter_place/index"
  post "api_system/index"

  post "api/index"
  get "api/index"
  post "api/upload"
  post "moniter/upload"

  resources :convert_rules


  get "images/display/:filename.:format\!:convert_rule" => "images#convert", :as=>'convert_image'
  get "images/display/:filename" => "images#display", :as=>'display_image'


  resources :images do
  end


  get "site/index"
  get "site/pjax", :as=>'pjax'

  devise_for :users, :controllers => {:sessions => "users/sessions", :registrations => "users/registrations"}

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'site#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
