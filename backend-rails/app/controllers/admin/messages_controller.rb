class Admin::MessagesController < ApplicationController
    before_action :set_message, only: [:show, :update, :destroy]

    def index
        render json: Message.all, status: 200
    end

    def show
        if params[:id]
            if @message
                render json: @message, status: 200
            else
                render json: { errors: [ "Message não existe" ] }, status: 400
            end
        end
    end

    def update
        if params[:id] 
            if @message.update(message_params)
                render json: @message, status: 200
            else
                render json: @message.errors, status: :unprocessable_entity
            end
      end
    end

    def destroy
        @message.destroy
        render json: { message: "Message deletada" }, status: 200
    end

    def create
        if params[:message] 
            @message = Message.new(message_params)
            if @message.save
                render json: @message, status: 200
            else
                render json: @message.errors, status: :unprocessable_entity
            end
        end
    end

    private

    def message_params
        params.require(:message).permit(:id, :title, :content, :type, :token, :mission_id, :task_id)
    end

    def set_message
      @message = Message.find(params[:id])
    end
end
