class Posts < Application
  
  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect resource(@post)
    else
      render :new
    end
  end

end