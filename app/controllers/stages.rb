class Stages < Application

  layout :application
  
  provides :html, :json
  
  def index
    @stages = Stage.all
    display @stages
  end

  def new
    @stage = Stage.new
    display @stage
  end
  
  def show
    @stage = Stage.get params[:id]
    display @stage
  end
  
  def create
    @stage = Stage.new(params[:stage])
    if @stage.save
      redirect resource(:admin, :stages)
    else
      render :new
    end
  end

  def upload
    only_provides :html
    @stage = Stage.new(params[:stage])
    @stage.image = params[:fileData]
    ## If the image belongs to a user, uncomment this line
    ## @image.user_id = session.user.id
    if @stage.save
      return 'success'
    else
      return ''
    end
  end

end