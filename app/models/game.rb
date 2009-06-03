class Game
  
  include DataMapper::Resource
  
  # properties
  
  property :id, Serial
  
  property :code_id, Integer, :nullable => false
  
  property :created_at, DateTime
  property :updated_at, DateTime
  
  # associations
  
  belongs_to :code
  
end