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

    def delete
      @post = Post.get params[:id]
      raise NotFound unless @post
      display @post
    end

    def destroy
      @post = Post.get params[:id]
      raise NotFound unless @post
      if @post.destroy
        redirect resource(:admin, :posts)
      else
        raise InternalServerError
      end
    end

  end
  
end