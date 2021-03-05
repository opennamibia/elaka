class MessagesController < ApplicationController
  invisible_captcha only: [:create]


  def new
    @message = Message.new
  end

  def create
    @message = Message.new message_params
    if @message.valid?
      MessageMailer.contact(@message).deliver_now
      redirect_to help_path
      flash[:notice] = "We have received your message and will be in touch soon!"
    else
      flash[:error] = "There was an error sending your message. Please try again."
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :subject, :content)
  end
end
