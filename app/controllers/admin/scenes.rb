module Admin
  
  class Scenes < Application

    layout :dashboard
    
    def index
      @scenes = Scene.all
      display @scenes
    end

    def new
      @scene = Scene.new
      display @scene
    end
    
    def show
      @scene = Scene.get params[:id]
      display @scene
    end
    
    def create
      @scene = Scene.new(params[:scene])
      if @scene.save
        redirect resource(:admin, :scenes)
      else
        render :new
      end
    end

    def upload
      only_provides :html
      @scene = Scene.new(params[:scene])
      @scene.image = params[:fileData]
      ## If the image belongs to a user, uncomment this line
      ## @image.user_id = session.user.id
      if @scene.save
        return 'success'
      else
        return ''
      end
    end

  end
  
end