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
    
    def create
      @scene = Scene.new(params[:scene])
      if @scene.save
        redirect resource(:admin, :scenes)
      else
        render :new
      end
    end

  end
  
end