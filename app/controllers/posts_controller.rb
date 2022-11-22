class PostsController < ApplicationController
  before_action :get_all_tags, except: :show
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to posts_path
    else
      render "new"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :tag_list)
  end

  def get_all_tags
    @all_tags = ActsAsTaggableOn::Tag.select(:name)
  end
end