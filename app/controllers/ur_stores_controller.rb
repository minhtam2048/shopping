class UrStoresController < ApplicationController
    
    before_action :authenticate_user!

    def show

        # @items = Item.all.where(user_id: .user)
    end

    def index     
        @user_items = Item.all.where(user_id: current_user.id).order("created_at DESC")
    end
    
   
    private 

    
   

    
end
