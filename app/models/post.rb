class Post
  
  include DataMapper::Resource
  
  property :id,               Serial
  
  property :stage_id,         Integer, :nullable => false
  property :style_id,         Integer, :nullable => false
  
  property :body,             String,  :nullable => false, :length => (1..160)
  
  property :text_color,       String,  :length => 6, :default => "FFFFFF"
  property :background_color, String,  :length => 6, :default => "FFFFFF"
  
  property :x_coord,          Integer
  property :y_coord,          Integer
  
  property :polygon,          Object
  
  property :created_at,       DateTime
  property :updated_at,       DateTime
  
  
  belongs_to :stage
  belongs_to :style
  
  
  delegate :name,        :to => :style, :prefix => true
  delegate :description, :to => :style, :prefix => true
  delegate :impact,      :to => :style, :prefix => true
  delegate :ttl,         :to => :style, :prefix => true
  
  
  before :save, :check_invitation_code!
  after  :save, :destroy_invitation_code!
  
  
  def ready?
    !new? && valid_invitation_code? && valid_coordinates?
  end
  
  def valid_coordinates?
    !self.x_coord.nil? && !self.y_coord.nil?
  end
  
  def valid_invitation_code?
    !@invitation_code.nil?
  end
  
  def invitation_code=(code)
    @invitation_code = Code.first(:secret => code)
    initialize_style_container! if @invitation_code
    @invitation_code
  end
  
  def invitation_code
    @invitation_code
  end
  
  
  protected
  
  # before filter
  def check_invitation_code!(*args)
    throw :halt  if new? && !valid_invitation_code?
  end
    
  # after filter
  def destroy_invitation_code!(*args)
    invitation_code.destroy if ready?
  end
  
  
  private
  
  def initialize_style_container!
    if new? && valid_invitation_code?
      self.polygon = style.generate_container
    end
  end
  
end