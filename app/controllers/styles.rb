class Styles < Application

  def index
    provides :html, :json
    @styles = Style.all
    display @styles
  end
  
  def show
    provides :html, :json
    @style = Style.get params[:id]
    display @style
  end

end