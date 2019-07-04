class ItemsController < ApplicationController
    before_action :find_item, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, only: [:new, :edit]
    # before_action :find_store
    def index
        if params[:category].blank?
            @items = Item.all.order("created_at DESC")
        end    
        
        if params[:category]
            
            @category_id = Category.find_by(name: params[:category]).id
            
            @items = Item.where(category_id: @category_id).order("created_at DESC")
        end

   
    end
    
    

    def show
    
        if @item.reviews.blank?
            @average_review = 0
        else  
            @average_review = @item.reviews.average(:rating).round(2)  
        end

    end

    def new
        # @item = Item.new
        @ur_store = current_user.ur_store
        @item = @ur_store.items.build
        @categories = Category.all.map{ |c| [c.name, c.id] }
       
        
    end
    
    

    def update
         @item.category_id = params[:category_id]
        if @item.update(item_params)
            redirect_to item_path(@item)
        else 
            render 'edit'
        end
    end

    def create
        @ur_store = current_user.ur_store 
        @item = @ur_store.items.build(item_params)
        @item.category_id = params[:category_id]
        if @item.save
           flash[:success] = "Creating item success"
           redirect_to @item    
        else
            render 'new'
        end
    end

    def edit
        @categories = Category.all.map{ |c| [c.name, c.id] }
    end
    
    def destroy
        return unless @item.destroy
        redirect_to items_path
    end
    
    def sort 
        if params[:items]
            @items_request = convert params[:items].values
            respond_to do |format|
                format.html
                format.js
            end
        end
    
    end

    def convert arr 
        newArr = []
        arr.each do |object|
            newMyObject = Item.new(object)
            newArr<<newMyObject
        end
        return newArr 
    end


    private

    def item_params
        params.require(:item).permit(:code, :name, :description, :producer, :item_img, :ur_store_id,
        :category_id  )
    end
    
    def find_item
        @item = Item.find(params[:id])
    end

    def find_store
        @ur_store = Item.find(params[:ur_store_id])
    end

    def find_user
        @user = User.find_by(params[:user_id]) 
    end
    
end
