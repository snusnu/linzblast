module Admin
  
  class Games < Application

    layout :dashboard

    provides :html, :json

    def index
      @games = Game.all
      display @games
    end

    def show
      @game = Game.get params[:id]
      display @game
    end

  end
  
end