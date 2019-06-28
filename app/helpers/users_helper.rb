module UsersHelper
    def conversation_interlocutor(conversation)
        conversation.recipent == current_user ? conversation.sender : conversation.recipent
    end 
end
