class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    # @comments = @blog.comment.includes(:user)
    if @comment.valid?
      redirect_to "/blogs/#{@comment.blog.id}"
    else
      redirect_to root_path                  # 一旦、indexへ飛びます
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, blog_id: params[:blog_id])
  end
end
