class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    comment = Comment.find(params[:comment][:parent_comment_id])
    @comment.post_id = comment.post_id
    if @comment.save
      redirect_to post_url(@comment.post_id)
    else
      render :new
    end

  end

  def new
    @comment = Comment.new
    @post_id = params[:post_id]
    render :new
  end


  def show
    @comment = Comment.find(params[:id])
    post = Post.find(@comment.post_id)
    @all_comments = post.comments_by_parent_id
    render :show
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :parent_comment_id)
  end

end
