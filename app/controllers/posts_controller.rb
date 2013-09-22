class PostsController < ApplicationController

  http_basic_authenticate_with name: "2pac", password: "2pac", except: [:index, :show]

  def index
  	@posts = Post.all
  end

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_params)

  	if @post.save
    	redirect_to @post
  	else
    	render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def show
  	@post = Post.find(params[:id])
  end

  private
  def post_params
    params.require(:post).permit(:title, :content)
  end

end
