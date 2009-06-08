class Wall
  
  include DataMapper::Resource
  
  # properties
  
  property :id,                 Serial

  property :name,               String,  :nullable => false, :length => (1..255)
  property :description,        Text,    :nullable => false
  
  property :access_restricted,  Boolean, :nullable => false

  # dm-paperclip properties

  property :wall_image_file_name,    String
  property :wall_image_content_type, String
  property :wall_image_file_size,    Integer
  property :wall_image_updated_at,   DateTime

  property :created_at,         DateTime
  property :updated_at,         DateTime
  property :deleted_at,         ParanoidDateTime

  # associations
  
  has n, :posts

  # support file uploads using dm-paperclip

  include Paperclip::Resource

  has_attached_file :wall_image, :styles => { :small => "200x200#", :medium => "400x400#" }


  # JSON export

  DEFAULT_TO_JSON_OPTIONS = {
    :only => [ :id, :name, :description, :access_restricted ],
    :methods => [ :original_image_url, :medium_image_url ],
    :relationships => { :posts => {} }
  }

  def to_json(*)
    super(DEFAULT_TO_JSON_OPTIONS)
  end
  
  def original_image_url
    wall_image.url
  end

  def medium_image_url
    wall_image.url(:medium)
  end

end