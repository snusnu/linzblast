class Code
  
  include DataMapper::Resource
  
  property :id,                 Serial
  property :code_generation_id, Integer, :nullable => false
  
  property :secret,             String,  :length => 40, :unique => true, :unique_index => true
  
  property :deleted_at,         ParanoidDateTime
  
  
  belongs_to :code_generation
  
  
  delegate :created_at, :to => :code_generation
  
  delegate :post_type,             :to => :code_generation
  delegate :post_type_name,        :to => :code_generation
  delegate :post_type_description, :to => :code_generation
  delegate :post_type_impact,      :to => :code_generation
  delegate :post_type_ttl,         :to => :code_generation
  
  
  def generator_name
    code_generation.user_name
  end
  
end