class Scene
  
  include DataMapper::Resource
  
  # properties
  
  property :id,          Serial
  
  property :name,        String, :nullable => false, :length => (1..255)
  property :description, Text,   :nullable => false
  
  property :uri,         URI,    :nullable => false, :length => (1..255)
  
  property :created_at, DateTime
  property :updated_at, DateTime
  
  # associations
  
  has n, :posts
  
end