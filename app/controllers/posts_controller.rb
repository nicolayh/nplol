class PostsController < ApplicationController

  http_basic_authenticate_with name: "2pac", password: "2pac", except: [:index, :show]

  before_filter :setup_negative_captcha, only: :show

  def index
  	@posts = Post.published
  end

  def new
  	@post = Post.new
  end

  def create
    meme? ? @post = Meme.new(meme_params) : @post = Post.new(post_params)
    @post.publish!
  	if @post.save
      redirect_to post_path(@post)
    else
    	render 'new'
    end
  end

  def meme
    @post = Meme.new
    render partial: 'meme_form', layout: false
  end

  def form
    @post = Post.new
    render partial: 'form', layout: false
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.meme? ? params = meme_params : params = post_params
    if @post.update(params)
      flash[:notice] = 'Post updated.'
      return redirect_to @post unless @post.meme?
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def show
  	@post = Post.find(params[:id])
    redirect_to root_path if @post.meme?
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit( :title, :content, :tag_list, :type,
                                  asset_attributes: [ :image ] )
  end

  def meme_params
    params.require(:post).permit( :title, :type, :tag_list, :image)
  end

  def meme?
    params[:post][:type] == 'Meme'
  end

end
