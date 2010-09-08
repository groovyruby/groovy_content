GroovyContent::Application.routes.draw do





  devise_for :users

  # Sample resource route within a namespace:
  namespace :admin do
    resources :menu_items
    resources :pages
    resources :sites
    root :to => "dashboard#index"
    match "dashboard/set_site_context", :to => "dashboard#set_site_context", :via => "post"
  end


  root :to => "home#index"


  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
