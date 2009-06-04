class CodeGeneration
  
  include DataMapper::Resource
  
  # properties
  
  property :id,                  Serial
  property :user_id,             Integer, :nullable => false
  property :style_collection_id, Integer, :nullable => false
  
  property :amount,              Integer, :nullable => false
  property :nr_of_posts,         Integer, :nullable => false
                                 
  property :created_at,          DateTime
  property :updated_at,          DateTime
  property :deleted_at,          ParanoidDateTime
  
  # associations
  
  belongs_to :user
  belongs_to :style_collection
  
  has n, :codes
  
  # TODO find out why this does strange things
  # has n, :styles, :through => :style_collection
  
  delegate :name,        :to => :style_collection, :prefix => true
  delegate :styles,      :to => :style_collection
  delegate :style_names, :to => :style_collection
  
  
  def self.random_secret
    /[:word:]/.gen
  end
  
  def user_name
    user.email  
  end
  
  protected
  
  after :save, :generate_codes
  
  def generate_codes(saved)
    return unless saved
    self.amount.times do
      Code.create(
        :code_generation_id  => self.id,
        :style_collection_id => self.style_collection.id,
        :secret              => self.class.random_secret, 
        :nr_of_posts         => self.nr_of_posts
      )
    end
  end
  
end