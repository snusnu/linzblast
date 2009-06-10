module Admin
  
  class Posts < Application

    layout :dashboard
    
    def index
      @posts = Post.all
      display @posts
    end
    
    def create
      @post = Post.new(params[:post])
      if @post.save
        redirect resource(:admin, @post)
      else
        render :new
      end
    end

  end
  
end