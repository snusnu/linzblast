module Admin
  
  class Codes < Application

    layout :dashboard
    
    def index
      Code.with_deleted do
        @codes = if params[:code_generation_id]
          @code_generation = CodeGeneration.get(params[:code_generation_id].to_i)
          @code_generation.codes
        else
          Code.all
        end
      end
      display @codes
    end

  end
  
end