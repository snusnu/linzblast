class PostType
  
  include DataMapper::Resource
  
  property :id,          Serial
  
  property :name,        String, :nullable => false, :length => 80
  property :description, Text
  
  property :impact,      Integer, :nullable => false
  property :ttl,         Integer, :nullable => false
  
  has n, :posts
  
end