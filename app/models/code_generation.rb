class CodeGeneration
  
  include DataMapper::Resource
  
  property :id,           Serial
  property :user_id,      Integer #, :nullable => false
  property :post_type_id, Integer, :nullable => false
  
  property :amount,       Integer, :nullable => false
  
  property :created_at,   DateTime
  property :updated_at,   DateTime
  
  
  belongs_to :user
  belongs_to :post_type
  
  has n, :codes
  
  
  delegate :name,        :to => :post_type, :prefix => true
  delegate :description, :to => :post_type, :prefix => true
  delegate :impact,      :to => :post_type, :prefix => true
  delegate :ttl,         :to => :post_type, :prefix => true
  
  
  def self.random_secret
    /[:word:]/.gen
  end
  
  def user_name
    user ? user.login : "Anonymous"  
  end
  
  protected
  
  after :save, :generate_codes!
  
  def generate_codes!(saved)
    return unless saved
    self.amount.times do
      Code.create(:code_generation_id => self.id, :secret => self.class.random_secret)
    end
  end
  
end