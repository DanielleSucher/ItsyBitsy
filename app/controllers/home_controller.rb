class HomeController < ApplicationController

  def about
  end

  def index
    if current_user.present?
      redirect_to user_path(current_user)
    else
      render action: 'about'
    end
  end

end
