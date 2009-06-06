class Style
  
  include BulletHole
  include DataMapper::Resource
  
  property :id,          Serial
  
  property :name,        String, :nullable => false, :length => (1..80)
  property :description, Text
  
  property :impact,      Integer, :nullable => false
  property :distortion,  Integer, :nullable => false
  property :ttl,         Integer, :nullable => false
  
  # dm-paperclip properties

  property :image_file_name,    String
  property :image_content_type, String
  property :image_file_size,    Integer
  property :image_updated_at,   DateTime
  
  property :symbol_image_file_name,    String
  property :symbol_image_content_type, String
  property :symbol_image_file_size,    Integer
  property :symbol_image_updated_at,   DateTime
  
  property :crosshair_image_file_name,    String
  property :crosshair_image_content_type, String
  property :crosshair_image_file_size,    Integer
  property :crosshair_image_updated_at,   DateTime

  property :created_at,  DateTime
  property :updated_at,  DateTime
  property :deleted_at,  ParanoidDateTime
  
  has n, :posts
  
  # support file uploads using dm-paperclip

  include Paperclip::Resource
  
  DM_PAPERCLIP_OPTIONS = {
    :default_url => "/uploads/images/:attachment/missing_:style.png",
    :url => "/uploads/images/:id/:style/:basename.:extension",
    :path => ":merb_root/public/uploads/images/:id/:style/:basename.:extension",
    :styles => {:small => "90x90#" }
  }

  has_attached_file :image, DM_PAPERCLIP_OPTIONS
  has_attached_file :symbol_image, DM_PAPERCLIP_OPTIONS
  has_attached_file :crosshair_image, DM_PAPERCLIP_OPTIONS
  
  extend DataMapper::Chainable
  
  # chainable do
  #   
  #   def image(*args)
  #     puts "YYYYYYYYYYYYY image: " + args.inspect
  #     super
  #   end
  # 
  #   def symbol_image(*args)
  #     puts "YYYYYYYYYYYYsymbol_image: " + args.inspect
  #     super
  #   end
  # 
  #   def crosshair_image(*args)
  #     puts "YYYYYYYYYYYYYYYYcrosshair_image: " + args.inspect
  #     super
  #   end
  # 
  # end
  
  
  BASE_RADIUS = 10
  
  def generate_container
    random_polygon(BASE_RADIUS, self.impact, self.distortion)
  end
  
end