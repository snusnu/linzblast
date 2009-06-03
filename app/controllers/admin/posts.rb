module Admin
  
  class Posts < Application

    layout :dashboard
    
    def index
      @posts = Post.all
      display @posts
    end

    def new
      @post = Post.new
      display @post
    end
    
    def show
      @post = Post.get params[:id]
      display @post
    end
    
    def create
      @post = Post.new(params[:post])
      if @post.save
        redirect resource(:admin, @post)
      else
        puts "X" * 80
        puts @post.errors.inspect
        puts "X" * 80
        render :new
      end
    end

  end
  
end