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
  
  has_attached_file :image
  has_attached_file :symbol_image
  has_attached_file :crosshair_image
  
  
  BASE_RADIUS = 10
  
  def generate_container
    random_polygon(BASE_RADIUS, self.impact, self.distortion)
  end

  # JSON export

  DEFAULT_TO_JSON_OPTIONS = {
    :only => [ :name, :description, :impact, :distortion, :ttl ],
    :methods => [ :image_url ]
  }

  def to_json(*)
    super(DEFAULT_TO_JSON_OPTIONS)
  end

  def image_url
    image.url
  end

end