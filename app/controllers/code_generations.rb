class CodeGenerations < Application
  controlling :code_generations do |g|
    g.actions :index, :new, :create
  end
  
  def redirect_on_successful_create
    resource(:code_generations)
  end
  
end