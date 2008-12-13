class Posts < Application
  
  controlling :posts do |p|
    p.actions :index, :new, :create, :update
  end
  
  def redirect_on_successful_create
    resource(member, :edit)
  end
  
end