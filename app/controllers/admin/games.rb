module Admin
  
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

  end
  
end