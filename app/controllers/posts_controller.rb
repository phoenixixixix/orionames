class PostsController < ApplicationController
  before_action :set_post, only: :show
  before_action :get_all_tags, only: :index
  add_breadcrumb I18n.t("breadcrumbs.main_page"), :root_path, only: %w(index show)
  add_breadcrumb I18n.t("breadcrumbs.blog_posts"), :posts_path, only: %w(index show)

  def index
    @posts = Post.all
    @posts = @posts.tagged_with(tag_param[:tag]) if tag_param[:tag]

    @posts = @posts.order(created_at: :desc).page(params[:page])
  end

  def show
    add_breadcrumb @post.title, post_path(@post)
    @photo = @post.get_unsplash_photo
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def tag_param
    params.permit(:tag)
  end

  def get_all_tags
    @all_tags = Post.all_tags
  end
end