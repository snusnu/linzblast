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
      raise NotFound unless @style
      display @style
    end
    
    def edit
      @style = Style.get params[:id]
      raise NotFound unless @style
      display @style
    end
    
    def create
      only_provides :json
      @style = Style.new(params[:style])
      if @style.save
        display @style.id
      else
        render :new
      end
    end
    
    def upload
      @style = Style.get(params[:id])
      if @style.respond_to?(params[:image_name])
        @style.send("#{params[:image_name]}=", params[:fileData])
        return 'success' if @style.save
      end
      return '' # be explicit
    end

  end
  
end