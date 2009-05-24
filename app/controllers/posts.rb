class Posts < Application

  def index
    provides :html, :json
    @posts = Post.all
    display @posts
  end
  
  def show
    provides :html, :json
    @post = Post.get params[:id]
    display @post
  end

  def new
    @post = Post.new
    display @post
  end
  
  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect resource(@post)
    else
      render :new
    end
  end

end