class MessagesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_message, only: %w[ show edit update destroy ]

  def index
    @messages = Message.all.order('created_at DESC')
  end

  def show
  end

  def new
    @message = current_user.messages.build
  end

  def create
    @message = current_user.messages.build(message_params)

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

  def edit
  end

  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to messages_path, notice: 'Message was updated successfully!' }
        format.json { render json: :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_path, notice: 'Message was deleted successfully!' }
      format.json { render json: @message.errors, status: :no_content }
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
