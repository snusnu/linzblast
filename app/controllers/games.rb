class Games < Application

  layout :application

  provides :html, :json
  
  def index
    @games = Game.all
    display @games
  end
  
  def show
    @game = Game.get params[:id]
    display @game
  end

  def create
    @game = Game.new(params[:game])
    if @game.save
      redirect resource(:admin, @game)
    else
      render :new
    end
  end

  def update
    @game = Game.get(params[:id])
    raise NotFound unless @game
    @game.update(params[:game])
    redirect resource(:admin, @game, :edit)
  end

end