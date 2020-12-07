class RelationshipsController < ApplicationController

  def index
   @user = User.find(params[:user_id])
  end

  def follow
    current_user.follow(params[:id])
    # redirect_to root_path
    if blog_path
    redirect_back(fallback_location: blog_path)
    else
    redirect_back(fallback_location: user_relationships_path)
    end
  end
  
  def unfollow
    current_user.unfollow(params[:id])
   if blog_path
    redirect_back(fallback_location: blog_path)
   else
    redirect_back(fallback_location: user_relationships_path)
   end
  end
  
  private
  def relationship_params
    params.require(:relationship).permit(follower_id: @user.id, followed_id: current_user.id )
  end
end
