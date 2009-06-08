class Style
  
  include BulletHole
  include DataMapper::Resource
  
  property :id,           Serial

  property :name,         String, :nullable => false, :length => (1..80)
  property :description,  Text

  property :impact,       Integer, :nullable => false
  property :distortion,   Integer, :nullable => false
  property :ttl,          Integer, :nullable => false
  
  property :type,         String
  property :manufacturer, String
  property :series,       String
  property :range,        String
  
  
  # dm-paperclip properties

  property :style_image_file_name,    String
  property :style_image_content_type, String
  property :style_image_file_size,    Integer
  property :style_image_updated_at,   DateTime
  
  property :style_symbol_image_file_name,    String
  property :style_symbol_image_content_type, String
  property :style_symbol_image_file_size,    Integer
  property :style_symbol_image_updated_at,   DateTime
  
  property :style_crosshair_image_file_name,    String
  property :style_crosshair_image_content_type, String
  property :style_crosshair_image_file_size,    Integer
  property :style_crosshair_image_updated_at,   DateTime

  property :created_at,  DateTime
  property :updated_at,  DateTime
  property :deleted_at,  ParanoidDateTime
  
  has n, :posts
  
  # support file uploads using dm-paperclip

  include Paperclip::Resource
  
  has_attached_file :style_image
  has_attached_file :style_symbol_image
  has_attached_file :style_crosshair_image
  
  
  BASE_RADIUS = 10
  
  def generate_container
    random_polygon(BASE_RADIUS, self.impact, self.distortion)
  end

  # JSON export

  DEFAULT_TO_JSON_OPTIONS = {
    :only => [ :name, :description, :impact, :distortion, :ttl ],
    :methods => [ :original_image_url ]
  }

  def to_json(*)
    super(DEFAULT_TO_JSON_OPTIONS)
  end

  def original_image_url
    style_image.url
  end

end