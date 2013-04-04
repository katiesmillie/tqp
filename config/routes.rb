TheQuestionProject::Application.routes.draw do
  

  devise_for :users, :controllers => { :registrations => "registrations" }

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  
  resources :authentications
  match '/auth/:provider/callback' => 'authentications#create'
  root :to => "rounds#index"
  
  match "/about" => "pages#about"
  match "/welcome" => "pages#signed_out"
  match "/new" => "pages#new_user"
  match "/testing" => "pages#testing"
  
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
  resources :answers, :only => [:create, :new, :edit, :update, :index]
  resources :questions, :only => [:create, :new]
  resources :rounds, :only => [:show]
  resources :pairs, :only => [:create, :new, :show, :destroy]
  resources :comments, :only => [:create, :edit, :update]
  resources :users, :only => :show
  
  resources :incoming_mails
  resources :invites, :only =>[:new, :create]
  

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
