class FollowersController < ApplicationController

  def create
    begin
      current_user.subscriptions.create user_id: user.id
      user.reload
    rescue  => e
      render_error e
    end
  end

  def destroy
    begin
      current_user.subscriptions.find(params[:id]).destroy
      user.reload
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
