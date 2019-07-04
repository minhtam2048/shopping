class UrStoresController < ApplicationController
    before_action :find_store, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!
    before_action :find_user

    def show
        
        #   @ur_store_idUrStore.where(user_id: @user.id).ids   
        
        if current_user.ur_store.blank?
            redirect_to :new
        else
            @items = Item.where(ur_store_id: @ur_store.id)   
        end
    end

    def index    
        @ur_stores = UrStore.all.order("created at DESC")    
    end
    
    def new
        @ur_store = current_user.build_ur_store
    end

    def create 
        @ur_store = current_user.build_ur_store(store_params)
        if @ur_store.save
            session[:ur_store_id] = @ur_store.id
           flash[:success] = "Creating item success"
           redirect_to @ur_store, notice: 'success'
        else
            render 'new'
        end
    end
   
    private 
    
   
    
    def store_params
        params.require(:ur_store).permit( :name , :user_id)
    end
    
    def find_store
        @ur_store = UrStore.find(params[:id])
    end

    def find_user
        @user = UrStore.find_by(params[:user_id])
    end

end

