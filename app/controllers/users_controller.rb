class UsersController < ApplicationController

  helper_method :users

  def index
  end

  private

  def users
    @users ||= User.includes(:group, :followers).where.not(id: current_user.id).order(:id);
  end
end
