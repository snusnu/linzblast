class Styles < Application

  layout :application

  provides :html, :json
  
  def index
    @styles = Style.all
    display @styles
  end
  
  def show
    @style = Style.get params[:id]
    display @style
  end

end