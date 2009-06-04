class Code
  
  include DataMapper::Resource
  
  # properties
  
  property :id,                  Serial
  property :code_generation_id,  Integer, :nullable => false
  property :style_collection_id, Integer, :nullable => false
  
  property :secret,              String,  :length => 40, :unique => true, :unique_index => true
  property :nr_of_posts,         Integer, :nullable => false
  
  property :created_at,          DateTime
  property :updated_at,          DateTime
  property :deleted_at,          ParanoidDateTime
  
  # associations
  
  belongs_to :code_generation
  belongs_to :style_collection
  
  delegate :style_names, :to => :style_collection
  
  def generator_name
    code_generation.user_name
  end
  
  def style_collection_name
    style_collection.name
  end
  
end