class PostCommentsController < ApplicationController
  def create
    osake = Osake.find(params[:osake_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.osake_id = osake.id
    comment.save
    redirect_to osake_path(osake)
  end

  def destroy
    post_comment = PostComment.find(params[:osake_id])
    post_comment.destroy
    redirect_to osake_path
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
