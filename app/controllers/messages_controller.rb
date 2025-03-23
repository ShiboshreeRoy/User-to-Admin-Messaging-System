class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin, only: [:index, :destroy]
  
  def index
    @messages = Message.all
   
  end

  def new
  
    @message = current_user.messages.build
    @number = Message.last&.number 
    @messages = current_user.messages.order(created_at: :desc)
  end

  def show
  end
  
  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      redirect_to root_path, notice: 'Deposit sent successfully!'
    else
      render :new
    end
  end

  def update_status
    @message = Message.find(params[:id])
    if @message.update(status: 'prossed')
      redirect_to messages_path, notice: 'Deposit processed successfully!'
    else
      redirect_to messages_path, alert: 'Failed to process deposit.'
    end
  end

  def destroy
    @message = Message.find(params[:id])
    if @message.destroy
      redirect_to messages_path, notice: 'Deposit deleted successfully!'
    else
      redirect_to messages_path, alert: 'Failed to delete Deposite.'
    end
  end

  private

  def message_params
    params.require(:message).permit(:title, :body, :amount, :number, :image)
  end

  def check_admin
    redirect_to root_path unless current_user.admin?
  end
end
