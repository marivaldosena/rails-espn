class MessagesController < ApplicationController
  def index
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to messages_path, notice: 'Message was created successfully!' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def message_params
      params.require(:message).permit(:title, :description)
    end
end
