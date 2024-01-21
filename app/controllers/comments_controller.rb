class CommentsController < ApplicationController
  def create # rubocop:disable Metrics/AbcSize
    post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = post.id

    if @comment.save
      redirect_to post_path(post)
    else
      @post = Post.find(params[:post_id])
      @comments = @post.comments.page(params[:page]).per(7).reverse_order
      render 'posts/show'
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
