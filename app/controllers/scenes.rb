class Scenes < Application

  layout :application
  
  provides :html, :json
  
  def index
    @scenes = Scene.all
    display @scenes
  end

  def show
    @scene = Scene.get params[:id]
    display @scene
  end

end