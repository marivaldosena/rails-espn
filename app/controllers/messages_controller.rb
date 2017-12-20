class MessagesController < ApplicationController
  before_action :find_message, only: %w[ show edit update destroy ]

  def index
    @messages = Message.all.order('created_at DESC')
  end

  def show
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

    def find_message
      @message = Message.find(params[:id])
    end
end
