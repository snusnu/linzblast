class Wall
  
  include DataMapper::Resource
  
  # properties
  
  property :id,                 Serial

  property :name,               String,  :nullable => false, :length => (1..255)
  property :description,        Text,    :nullable => false
  
  property :access_restricted,  Boolean, :nullable => false

  # dm-paperclip properties

  property :image_file_name,    String
  property :image_content_type, String
  property :image_file_size,    Integer
  property :image_updated_at,   DateTime

  property :created_at,         DateTime
  property :updated_at,         DateTime
  property :deleted_at,         ParanoidDateTime

  # associations
  
  has n, :posts

  # support file uploads using dm-paperclip

  include Paperclip::Resource

  has_attached_file :image


  # JSON export

  DEFAULT_TO_JSON_OPTIONS = {
    :only => [ :name, :description, :access_restricted ],
    :methods => [ :image_url ],
    :relationships => { :posts => {} }
  }

  def to_json(*)
    super(DEFAULT_TO_JSON_OPTIONS)
  end
  
  def image_url
    image.url
  end

end