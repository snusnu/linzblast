module Admin
  
  class Codes < Application

    layout :dashboard
    
    def index
      @codes = if params[:code_generation_id]
        @code_generation = CodeGeneration.first params[:code_generation_id].to_i
        @code_generation.codes.all
      else
        Code.all
      end
      display @codes
    end

  end
  
end