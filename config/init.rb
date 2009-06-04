# Go to http://wiki.merbivore.com/pages/init-rb
 
require 'config/dependencies.rb'
 
use_orm :datamapper
use_test :rspec
use_template_engine :erb
 
Merb::Config.use do |c|
  c[:use_mutex] = false
  c[:session_store] = 'cookie'  # can also be 'memory', 'memcache', 'container', 'datamapper
  
  # cookie session store configuration
  c[:session_secret_key]  = 'ba9baa83815a89fd66eb6a91fcec4499202aed79'  # required for cookie session store
  c[:session_id_key] = '_lbl_session_id' # cookie session id key, defaults to "_session_id"
end
 
Merb::BootLoader.before_app_loads do
  # This will get executed after dependencies have been loaded but before your app's classes have loaded.
  
  # include support for "delegate" a la rails
  require Merb.root / "lib" / "delegation"
  
  # commonly used date formats
  Date.add_format(:hm,  "%H:%M")
  Date.add_format(:dmy, "%d/%m/%Y")
  Date.add_format(:dmyhm, "%d/%m/%Y-%H:%M")
  
end
 
Merb::BootLoader.after_app_loads do
  # This will get executed after your app's classes have been loaded.
end
