module Admin
  
  class Walls < Application

    layout :dashboard
    
    def index
      @walls = Wall.all
      display @walls
    end

    def new
      @wall = Wall.new
      display @wall
    end
    
    def show
      @wall = Wall.get params[:id]
      display @wall
    end
    
    def create
      @wall = Wall.new(params[:wall])
      if @wall.save
        redirect resource(:admin, :walls)
      else
        render :new
      end
    end

    def upload
      only_provides :html
      @wall = Wall.new(params[:wall])
      @wall.image = params[:fileData]
      if @wall.save
        return 'success'
      else
        return ''
      end
    end

  end
  
end