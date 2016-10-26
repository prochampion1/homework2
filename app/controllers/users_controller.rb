    class UsersController < ApplicationController

  def index
  Rails.logger.info request.env["HTTP_COOKIE"]
    @users = User.all
    @users = User.where.not(id: current_user.id)
  end

  def new
    @user = User.new
  end
  def show 
    @friendships = Friendship.all
    @users = User.all

  end 
  def create 
    @user=User.create user_params
    if @user.persisted?
      session[:user_id]= @user.id
      flash[:success]= "registed successfully"
      redirect_to root_path

    else
      flash[:error]= "Error: #{@user.errors.full_messages}"
      render 'new'
    end
  end

 def sent_message
    @current_user_conversations = Conversation.where('sender_id = ?',current_user.id)
    @sent_messages = []
    @current_user_conversations.each do |current_user_conversation|
      current_user_conversation.messages.each do |message|
        @sent_messages << message
      end
    end
  end

    # def group_message
    #   before_action :authenticate_user
    #   query = params[:search]
    #   @users = current_user.friendships(params[:friend_id]).where("user.name LIKE ? OR user.email LIKE ? " ,"%#{query}%").excludes(:id=> current_user.id)
    #   @message = @conversation.messages.new
    # end
 

  private 
  def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
