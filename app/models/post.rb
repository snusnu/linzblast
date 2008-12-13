class Post
  
  include DataMapper::Resource
  
  property :id,               Serial
  property :post_type_id,     Integer, :nullable => false
  
  property :body,             String,  :length => 255
  
  property :text_color,       String,  :length => 6, :default => "FFFFFF"
  property :background_color, String,  :length => 6, :default => "FFFFFF"
  
  property :created_at,       DateTime
  property :updated_at,       DateTime
  
  
  belongs_to :post_type
  
  
  delegate :name,        :to => :post_type, :prefix => true
  delegate :description, :to => :post_type, :prefix => true
  delegate :impact,      :to => :post_type, :prefix => true
  delegate :ttl,         :to => :post_type, :prefix => true
  
end