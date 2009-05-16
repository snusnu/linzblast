merb_gems_version  = "~>1.0.11"
dm_gems_version    = "~>0.9.11"

dependency "merb-assets", merb_gems_version  
dependency "merb-cache", merb_gems_version   
dependency "merb-helpers", merb_gems_version
dependency "merb-slices", merb_gems_version  
dependency "merb-auth-core", merb_gems_version
dependency "merb-auth-more", merb_gems_version
dependency "merb-auth-slice-password", merb_gems_version
dependency "merb-param-protection", merb_gems_version
 
dependency "dm-core", dm_gems_version         
dependency "dm-aggregates", dm_gems_version
dependency "dm-timestamps", dm_gems_version   
dependency "dm-types", dm_gems_version        
dependency "dm-validations", dm_gems_version
dependency "dm-constraints", dm_gems_version
dependency "dm-serializer", dm_gems_version
dependency "dm-sweatshop", dm_gems_version

dependency 'merb_resource_controller', "0.2.0"