module Admin
  
  class Styles < Application

    layout :dashboard
    
    def index
      @styles = Style.all
      display @styles
    end

    def new
      @style = Style.new
      display @style
    end
    
    def show
      @style = Style.get params[:id]
      display @style
    end
    
    def create
      @style = Style.new(params[:style])
      if @style.save
        redirect resource(:admin, :styles)
      else
        render :new
      end
    end

  end
  
end