class Post
  
  include DataMapper::Resource
  
  # properties
  
  property :id,               Serial
  
  property :wall_id,          Integer, :nullable => false
  property :style_id,         Integer, :nullable => false
  
  property :body,             String,  :nullable => false, :length => (1..160)
  
  property :text_color,       String,  :length => 6, :default => "FFFFFF"
  property :background_color, String,  :length => 6, :default => "FFFFFF"
  
  property :x_coord,          Integer, :nullable => false
  property :y_coord,          Integer, :nullable => false
  property :dest_x,           Integer, :nullable => false
  
  property :polygon,          Object
  
  property :created_at,       DateTime
  property :updated_at,       DateTime
  property :deleted_at,       ParanoidDateTime
  
  # associations
  
  belongs_to :wall
  belongs_to :style
  
  # delegations
  
  delegate :name,        :to => :style, :prefix => true
  delegate :description, :to => :style, :prefix => true
  delegate :impact,      :to => :style, :prefix => true
  delegate :ttl,         :to => :style, :prefix => true
  

  before :save, :initialize_style_container

  protected
  
  # before save hook
  def initialize_style_container
    if new?
      self.polygon = style.generate_container
    end
  end
  
end