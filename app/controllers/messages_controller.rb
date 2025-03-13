class MessagesController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin, only: [:index]
  
    def index
      @messages = Message.all
    end
  
    def new
      
      @message = current_user.messages.build
      @messages = current_user.messages.order(created_at: :desc) 
    end

    def show

    end
    def create
      @message = current_user.messages.build(message_params)
      if @message.save
        redirect_to root_path, notice: 'Message sent successfully!'
      else
        render :new
      end
    end

    def update_status
        @message = Message.find(params[:id])
        if @message.update(status: 'processed')
          redirect_to messages_path, notice: 'Message processed successfully!'
        else
          redirect_to messages_path, alert: 'Failed to process message.'
        end
      end

    private
  
    def message_params
      params.require(:message).permit(:title, :body, :image)
    end
  
    def check_admin
      redirect_to root_path unless current_user.admin?
    end
  end