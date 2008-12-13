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
  
  
  def valid_invitation_code?
    !invitation_code.nil?
  end
  
  def invitation_code=(code)
    @invitation_code = Code.first(:secret => code)
    self.post_type_id = invitation_code.post_type.id if @invitation_code
    @invitation_code
  end
  
  def invitation_code
    @invitation_code
  end
  
  
  protected
  
  before :save, :check_invitation_code!
  
  def check_invitation_code!(*post)
    throw :halt if new_record? && !self.valid_invitation_code?
  end
  
end