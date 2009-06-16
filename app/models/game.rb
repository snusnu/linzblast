class Game
  
  include DataMapper::Resource
  
  # properties
  
  property :id,          Serial

  property :wall_id,     Integer, :nullable => false

  property :nr_of_posts, Integer, :nullable => false, :default => 0
  
  property :created_at,  DateTime
  property :updated_at,  DateTime
  property :deleted_at,  ParanoidDateTime
  
  # associations

  belongs_to :wall


  # virtual attributes
  
  def code=(secret)
    @code = Code.first(:secret => secret)
  end
  
  def code
    @code
  end
  
  
  # validation
  
  def valid?(context = :default)
    (wall.access_restricted ? !code.nil? : true) && super
  end


  # public api

  def update(attributes, context = :default)
    if post = attributes.delete(:post)
      po = Post.create(post)
    end
    self.code = attributes[:code]
    self.nr_of_posts += 1
    stop_if_necessary
    super({})
  end
  
  def available_styles
    code ? code.styles : Style.all
  end
  
  
  # JSON export
  
  DEFAULT_TO_JSON_OPTIONS = {
    :only => [ :id, :created_at, :updated_at ],
    :methods => [ :posts_left?, :available_styles ],
    :relationships => { :wall => {} }
  }
  
  def to_json(*)
    super(DEFAULT_TO_JSON_OPTIONS)
  end

  def posts_left?
    code ? nr_of_posts == code.nr_of_posts : true
  end

  private
    
  def stop_if_necessary
    if wall.access_restricted? && !posts_left?
      code.destroy
    end
  end
  
end