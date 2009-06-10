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
    
    def update
      only_provides :json
      @style = Style.get params[:id]
      raise NotFound unless @style
      if @style.update(stripped_style_params)
        display @style.id
      else
        render :edit
      end
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
    
    private
    
    def stripped_style_params
      return params unless params[:style]
      params[:style].delete(:style_image_name)
      params[:style].delete(:style_symbol_image_name)
      params[:style].delete(:style_crosshair_image_name)
      params
    end

  end
  
end