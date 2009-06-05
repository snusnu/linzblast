class Stage < Application
  
  provides :json
  
  def show
    stage = {}
    stage[:walls] = Wall.all
    stage[:styles] = Style.all
    display stage
  end
  
end