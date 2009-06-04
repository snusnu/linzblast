class StyleCollection
  
  include DataMapper::Resource
  
  property :id,          Serial
  
  property :name,        String, :nullable => false, :length => (1..255)
  property :description, Text
  
  has n, :style_collection_memberships
  has n, :styles, :through => :style_collection_memberships
  
  def style_names
    styles.map { |style| style.name }
  end
  
end