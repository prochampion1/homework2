class ConversationsController < ApplicationController
   before_action :authenticate_user
   after_action :update_read, only: [:index]
   

  def index
   @users = User.where.not(id: current_user.id)
   @conversations = Conversation.for(current_user.id)
  end

  def create

    if Conversation.between(params[:sender_id],params[:recipient_id])
     .present?
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
   else
    @conversation = Conversation.create!(conversation_params)
   end
   redirect_to conversation_messages_path(@conversation)
  end


  def all

    @users = User.where.not(id: current_user.id)
   @conversations = Conversation.for(current_user.id)
   
  end
  
  def unread
   @users = User.where.not(id: current_user.id)
   @conversations = Conversation.for(current_user.id)
  end


  private 
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
  def update_read
    Message.joins(:conversation).where(read: false, read_at: nil).where(conversations: {id: @conversations.pluck(:id)}).update(read: true, read_at: Time.now)

  end

  
end
