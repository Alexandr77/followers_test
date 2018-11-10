class ApplicationController < ActionController::Base

  before_action :auth!
  helper_method :current_user

  protected

  def auth!
    render_not_found unless current_user
  end

  def current_user
    @current_user ||= User.find_by_id user_id if user_id
  end

  def user_id
    cookies[:user_id]
  end

  def render_not_found
    render json: {"error": 'Forbidden' },  status: 401
  end

end
