GroovyContent::Application.routes.draw do

  resources :property_types

  get "pages/index"

  get "pages/show"

  devise_for :users

  # Sample resource route within a namespace:
  namespace :admin do
    resources :menu_items do
      collection do
        post 'sort'
      end
    end
    resources :page_types do
      get 'list_type', :on=>:member
    end
    resources :pages
    resources :sites
    resources :templates
    root :to => "dashboard#index"
    match "dashboard/set_site_context", :to => "dashboard#set_site_context", :via => "post"
  end


  root :to => "pages#index"


  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
