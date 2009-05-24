class Code
  
  include DataMapper::Resource
  
  property :id,                 Serial
  property :code_generation_id, Integer, :nullable => false
  
  property :secret,             String,  :length => 40, :unique => true, :unique_index => true
  
  property :deleted_at,         ParanoidDateTime
  
  
  belongs_to :code_generation
  
  delegate :created_at, :to => :code_generation
  
  def generator_name
    code_generation.user_name
  end
  
  def style_collection_name
    code_generation.style_collection_name
  end
  
end