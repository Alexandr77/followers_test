class FollowersController < ApplicationController

  def create
    begin
      user.followers.create follower_id: current_user.id
    rescue  => e
      render_error e
    end
  end

  def destroy
    begin
      user.followers.find(params[:id]).destroy
    rescue => e
      render_error e
    end
  end

  private

  def attrs
    @attrs ||= params.require(:follower).permit(:user_id)
  end

  def user
    @user ||= User.find attrs[:user_id]
  end

  def render_error(e)
    render partial: 'error', locals: { err: e }, status: :bad_data
  end

end
