module Admin
  
  class CodeGenerations < Application

    layout :dashboard
    
    def index
      @code_generations = CodeGeneration.all
      display @code_generations
    end

    def new
      @code_generation = CodeGeneration.new
      display @code_generation
    end
    
    def create
      @code_generation = CodeGeneration.new(params[:code_generation].merge(:user => session.user))
      if @code_generation.save
        redirect resource(:admin, :code_generations)
      else
        render :new
      end
    end

  end
  
end