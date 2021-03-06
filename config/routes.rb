GroovyContent::Application.routes.draw do

  resources :inquiries, :only=>[:new, :create]

  resources :pages

  devise_for :users

  # Sample resource route within a namespace:
  namespace :admin do
    resources :inquiries, :only=>[:show, :destroy]
    resources :inquiry_forms do
      get 'list_type', :on=>:member
    end
    resources :menu_items do
      collection do
        post 'sort'
        get 'reorder'
      end
    end
    resources :page_types do
      get 'list_type', :on=>:member
    end
    resources :pages do
      member do
        post 'sort'
      end
    end
    resource :setting
    resources :sites
    resources :templates
    resources :users do
      get 'switch_admin', :on=>:member
    end
    root :to => "dashboard#index"
    match "dashboard/set_site_context", :to => "dashboard#set_site_context", :via => "post"
  end


  root :to => "pages#index"


  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  match ':id', :to=>"pages#show", :via=>"get"
end
