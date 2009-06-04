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
    if @game.save
      redirect resource(@game, :edit)
    else
      render :new
    end
  end
  
  def update
    @game = Game.get(params[:id])
    raise NotFound unless @game
    if @game.update(params[:game])
      redirect resource(@game, :edit)
    else
      render :new
    end
  end

end