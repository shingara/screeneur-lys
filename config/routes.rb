ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.
  map.resources :users
  map.resources :sessions
  map.resources :screens
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)
  map.connect '/script', :controller => "screens", :action => "script"

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  map.welcome '', :controller => "screens", :action => "new"
  map.map_view '/maps/:x/:y/:step/:map_id', :controller => "maps", :actions => "index"

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
