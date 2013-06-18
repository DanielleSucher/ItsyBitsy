class UsersController < ApplicationController
  before_filter :authenticate

  def destroy
    @user = User.find params[:id]
    @user.destroy
    redirect_to signout_path
  end

  def show
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    @user.update_attributes params[:user]
    redirect_to user_path(@user)
  end

end