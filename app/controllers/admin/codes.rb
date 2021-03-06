module Admin
  
  class Codes < Application

    layout :dashboard
    
    def index
      # FIXME wait for datamapper to properly support Resource.with_deleted
      @codes = if params[:code_generation_id]
        @code_generation = CodeGeneration.get(params[:code_generation_id].to_i)
        @code_generation.codes
      else
        Code.all
      end
      display @codes
    end

  end
  
end