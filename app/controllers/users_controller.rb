class UsersController < ApplicationController

    before_action :find_user , only: [:edit, :update, :destroy] 
    def index
		@users = User.all
		
		@conversations = Conversation.involving(current_user).order("created_at DESC")
    end
    
    def new
		@user = User.new
		
    end
    
   
    def show 
        @user = User.find_by(id: params[:id])
    end

    def create
    	@user = User.new(user_params)
    	if @user.save
     		redirect_to admin_users_path
     		flash[:success] = "Success"
    	else
    		flash[:danger] = "Failed"
     		render 'new'
    	end
  	end


	def edit
	end

	def update
		if @user.update_attributes(user_params)
			redirect_to users_path
			flash[:success] = "Success"
		else
			flash[:danger] = "Failed"
			render 'edit'
		end
	end
	
	def destroy
		if @user.present?
      		@user.destroy
      		flash[:success] = "Success "
    	else
    		flash[:success] = "Failed"
		end
    	redirect_to users_path
	end

	private
		def user_params
    		params.require(:user).permit(:name, :email,:phone,:address,:password,
                                   :password_confirmation)
    	end


		def find_user
			@user = User.find(params[:id])
        end
end
