class ConversationsController < ApplicationController
    before_action :authenticate_user!
    # run this code in another terminal
    # rackup private_pub.ru -s thin -E production
    # layout false

    def create
        if Conversation.between(params[:sender_id], params[:recipent_id]).present?
            @conversation = Conversation.between(params[:sender_id], params[:recipent_id]).first
        else
            @conversation = Conversation.create!(conversation_params)
        end
        
        render json: {conversation_id: @conversation.id}
    end

    def show
        @conversation = Conversation.find(params[:id])
        @receiver = interlocutor(@conversation)
        @messages = @conversation.messages
        @message = Message.new
    end

    private

    def conversation_params
        params.permit(:sender_id, :recipent_id)
    end

    def interlocutor(conversation)
        current_user == conversation.recipent ? conversation.sender : conversation.recipent
    end
end
