class Posts < Application
  
  controlling :posts do |p|
    p.actions :index, :new, :create
  end
  
  def redirect_on_successful_create
    resource(member, :edit)
  end
  
end


class CodeGenerations < Application

  layout :dashboard
  
  def index
    @posts = Post.all
    display @posts
  end

  def new
    @post = Post.new
    display @post
  end
  
  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect resource(:admin, :posts)
    else
      render :new
    end
  end

end