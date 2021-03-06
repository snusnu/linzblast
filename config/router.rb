# Merb::Router is the request routing mapper for the merb framework.
#
# You can route a specific URL to a controller / action pair:
#
#   match("/contact").
#     to(:controller => "info", :action => "contact")
#
# You can define placeholder parts of the url with the :symbol notation. These
# placeholders will be available in the params hash of your controllers. For example:
#
#   match("/books/:book_id/:action").
#     to(:controller => "books")
#   
# Or, use placeholders in the "to" results for more complicated routing, e.g.:
#
#   match("/admin/:module/:controller/:action/:id").
#     to(:controller => ":module/:controller")
#
# You can specify conditions on the placeholder by passing a hash as the second
# argument of "match"
#
#   match("/registration/:course_name", :course_name => /^[a-z]{3,5}-\d{5}$/).
#     to(:controller => "registration")
#
# You can also use regular expressions, deferred routes, and many other options.
# See merb/specs/merb/router.rb for a fairly complete usage sample.

Merb.logger.info("Compiling routes...")
Merb::Router.prepare do

  resource  :stage, :controller => 'stage'
  resources :games
  resources :walls
  resources :posts
  resources :styles
  
  authenticate do

    # support multiple file uploads to the images controller

    with(:controller => "admin/walls") do
      match('/admin/walls/upload').to(:action => "upload").fixatable
    end
    
    with(:controller => "admin/styles") do
      match('/admin/styles/upload').to(:action => "upload").fixatable
    end

    namespace :admin do

      resource  :dashboard, :controller => 'dashboard'

      resources :games
      resources :posts
      resources :codes
      resources :styles
      resources :walls
      resources :code_generations do
        resources :codes
      end

    end

  end
  
  # Adds the required routes for merb-auth using the password slice
  slice(:merb_auth_slice_password, :name_prefix => nil, :path_prefix => "")
  
  match('/').to(:controller => 'walls', :action =>'index')
end