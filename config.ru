# config.ru
require 'rubygems'
require 'merb-core'
 
Merb::Config.setup(:merb_root => File.expand_path(File.dirname(__FILE__)),
                   :environment => ENV['RACK_ENV'])
Merb.environment = Merb::Config[:environment]
Merb.root = Merb::Config[:merb_root]
Merb::BootLoader.run
 
# Uncomment if your app is mounted at a suburi  
#if prefix = ::Merb::Config[:path_prefix] 
#  use Merb::Rack::PathPrefix, prefix 
#end 
 
run Merb::Rack::Application.new