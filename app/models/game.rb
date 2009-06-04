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
  
  def valid?(context = :default)
    stage.access_restricted ? !code.nil? : true
  end


  # public api

  def update(attributes, context = :default)
    attributes.delete(:nr_of_posts) # no playin around
    if post = attributes.delete(:post)
      Post.create(post)
    end
    self.nr_of_posts += 1
    stop_game_if_necessary
    super
  end
  
  def available_styles
    code ? code.styles : Style.all
  end
  
  
  # JSON export
  
  DEFAULT_TO_JSON_OPTIONS = {
    :only => [ :id, :created_at, :updated_at ],
    :methods => [ :posts_left?, :available_styles ],
    :relationships => { :stage => {} }
  }
  
  def to_json(*)
    super(DEFAULT_TO_JSON_OPTIONS)
  end

  def posts_left?
    code ? nr_of_posts == code.nr_of_posts : true
  end

  private
    
  def stop_game_if_necessary
    if stage.access_restricted? && !posts_left?
      code.destroy
    end
  end
  
end