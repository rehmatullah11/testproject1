class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :authenticate_user!

  def show
    if can? :show, @user
      @user_projects = @user.created_projects
      @user_solbugs = @user.solved_bugs
      @user_createdbugs = @user.created_bugs
    else
      flash[:danger] = "You cannot view other user's profile"
      redirect_to user_path(current_user)
    end
  end

private

  def set_user
    @user = User.find(params[:id])
  end

end