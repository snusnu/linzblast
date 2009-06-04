class Game
  
  include DataMapper::Resource
  
  # properties
  
  property :id,          Serial
  
  property :stage_id,    Integer, :nullable => false
  
  property :nr_of_posts, Integer, :nullable => false, :default => 0
  
  property :created_at,  DateTime
  property :updated_at,  DateTime
  
  # associations
  
  belongs_to :stage
  
  
  # virtual attributes
  
  def code=(secret)
    @code = Code.first(:secret => secret)
  end
  
  def code
    @code
  end
  
  
  # validation
  
  def valid?
    stage.access_restricted ? !code.nil? : true
  end
  
  after :save, :stop_game_if_necessary
  
  
  # public api
  
  def save(context = :default)
    super
  end
  
  
  protected
    
  # after filter
  def stop_game_if_necessary(*args)
    if stage.access_restricted? && no_posts_left?
      code.destroy
    end
  end
  
  def no_posts_left?
    nr_of_posts == code.nr_of_posts
  end
  
end