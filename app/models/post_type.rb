class PostType
  
  include BulletHole
  include DataMapper::Resource
  
  property :id,          Serial
  
  property :name,        String, :nullable => false, :length => 80
  property :description, Text
  
  property :impact,      Integer, :nullable => false
  property :distortion,  Integer, :nullable => false
  property :ttl,         Integer, :nullable => false
  
  has n, :posts
  
  BASE_RADIUS = 10
  
  def generate_container
    random_polygon(BASE_RADIUS * impact, self.distortion)
  end
  
end