class CodeGeneration
  
  include DataMapper::Resource
  
  property :id,                  Serial
  property :user_id,             Integer, :nullable => false
  property :style_collection_id, Integer, :nullable => false
  
  property :amount,              Integer, :nullable => false
                                 
  property :created_at,          DateTime
  property :updated_at,          DateTime
  
  
  belongs_to :user
  belongs_to :style_collection
  
  has n, :codes
  
  
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