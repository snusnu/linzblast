class Style
  
  include BulletHole
  include DataMapper::Resource
  
  property :id,          Serial
  
  property :name,        String, :nullable => false, :length => (1..80)
  property :description, Text
  
  property :impact,      Integer, :nullable => false
  property :distortion,  Integer, :nullable => false
  property :ttl,         Integer, :nullable => false

  property :created_at,  DateTime
  property :updated_at,  DateTime
  property :deleted_at,  ParanoidDateTime
  
  has n, :posts
  
  BASE_RADIUS = 10
  
  def generate_container
    random_polygon(BASE_RADIUS, self.impact, self.distortion)
  end
  
end