class HomeController < ApplicationController
  def index
   Rails.logger.info request.env["HTTP_COOKIE"]
   if current_user
    @users = User.where.not(id: current_user.id)
  else 
    @users =User.all
   end
  end
end 
