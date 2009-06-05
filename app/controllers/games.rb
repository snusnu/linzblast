class Games < Application

  layout :application

  provides :html, :json
  
  def index
    @games = Game.all
    display @games
  end
  
  def new
    @game = Game.new
    display @game
  end

  def show
    @game = Game.get params[:id]
    raise NotFound unless @game
    display @game
  end

  def edit
    @game = Game.get params[:id]
    raise NotFound unless @game
    display @game
  end

  def create
    @game = Game.new(params[:game])
    case params[:format]
    when 'json'
      if @game.save
        display @game, :status => OK.status
      else
        display @game, :status => Unauthenticated.status
      end
    else
      render :layout => false, :status => UnsupportedMediaType.status
    end
  end
  
  def update
    @game = Game.get(params[:id])
    raise NotFound unless @game
    case params[:format]
    when 'json'
      if @game.update(params[:game])
        display @game, :status => OK.status
      else
        display @game, :status => Unauthenticated.status
      end
    else
      render :layout => false, :status => UnsupportedMediaType.status
    end
  end

end