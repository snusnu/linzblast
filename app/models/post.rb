class Post
  
  include DataMapper::Resource
  
  property :id,               Serial
  property :post_type_id,     Integer, :nullable => false
  
  property :body,             String,  :length => 255
  
  property :text_color,       String,  :length => 6, :default => "FFFFFF"
  property :background_color, String,  :length => 6, :default => "FFFFFF"
  
  property :created_at,       DateTime
  property :updated_at,       DateTime
  
  property :x_coord,          Integer
  property :y_coord,          Integer
  
  property :polygon,          Object
  
  
  belongs_to :post_type
  
  
  delegate :name,        :to => :post_type, :prefix => true
  delegate :description, :to => :post_type, :prefix => true
  delegate :impact,      :to => :post_type, :prefix => true
  delegate :ttl,         :to => :post_type, :prefix => true
  
  
  before :save, :check_invitation_code!
  after  :save, :destroy_invitation_code!
  
  
  def ready?
    !new_record? && valid_invitation_code? && valid_coordinates?
  end
  
  def valid_coordinates?
    !self.x_coord.nil? && !self.y_coord.nil?
  end
  
  def valid_invitation_code?
    !@invitation_code.nil?
  end
  
  def invitation_code=(code)
    @invitation_code = Code.first(:secret => code)
    initialize_post_type_container! if @invitation_code
    @invitation_code
  end
  
  def invitation_code
    @invitation_code
  end
  
  
  protected
  
  # before filter
  def check_invitation_code!(*args)
    throw :halt  if new_record? && !valid_invitation_code?
  end
    
  # after filter
  def destroy_invitation_code!(*args)
    invitation_code.destroy if ready?
  end
  
  
  private
  
  def initialize_post_type_container!
    if new_record? && valid_invitation_code?
      self.post_type = invitation_code.post_type
      self.polygon = post_type.generate_container
    end
  end
  
end