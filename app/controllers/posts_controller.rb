class PostsController < ApplicationController
  before_action :require_login, only: [:edit, :new, :create, :update]
  before_action :require_author, only: [:edit, :update]

  def create
    @post = Post.new(post_params)
    params[:sub_id].each do |sub_id|
      @post.post_subs.new(sub_id: sub_id)
    end

    if @post.save
      redirect_to post_url(@post)
    else
      render :new
    end

  end

  def new
    @post = Post.new
    @subs = Sub.all
    @sub_id = params[:id]
    render :new
  end

  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all
    render :edit
  end

  def update
    @post = Post.find(params[:id])
    if params[:sub_id]
      @post.post_subs.each(&:destroy)
      params[:sub_id].each do |sub_id|
        @post.post_subs.new(sub_id: sub_id)
      end
      if @post.update(post_params)

        redirect_to post_url(@post)
        return
      end
    end
      @subs = Sub.all
      render :edit
  end

  def show
    @post = Post.find(params[:id])
    @all_comments = @post.comments_by_parent_id #includes: :author
    render :show
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to subs_url
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :url, :sub_id, :author_id)
  end

  def require_author
    @post = Post.find(params[:id])
    unless @post.author_id == current_user.id
      flash[:error] = "You must be OP to edit or update"
      redirect_to sub_url(post.sub_id)
    end
  end

end
