class UsersController < ApplicationController
  before_filter :authenticate

  def show
  end

  def update
    @user = User.find params[:id]
    @user.update_attributes params[:user]
    redirect_to root_path
  end
end