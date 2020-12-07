class RelationshipsController < ApplicationController

  def index
   @user = User.find(params[:user_id])
  end

  def follow
    current_user.follow(params[:id])
    redirect_to root_path
  end
  
  def unfollow
    current_user.unfollow(params[:id])
    redirect_to root_path
  end
  
  private
  def relationship_params
    params.require(:relationship).permit(follower_id: @user.id, followed_id: current_user.id )
  end
end
