class StyleCollectionMembership
  
  include DataMapper::Resource
  
  property :id, Serial
  
  property :style_collection_id, Integer, :nullable => false
  property :style_id,            Integer, :nullable => false
  
  property :created_at,          DateTime
  property :updated_at,          DateTime
  property :deleted_at,          ParanoidDateTime
  
  
  belongs_to :style_collection
  belongs_to :style
  
end