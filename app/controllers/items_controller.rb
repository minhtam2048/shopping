class ItemsController < ApplicationController
    before_action :find_item, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, only: [:new, :edit]
    
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
        @item = current_user.items.build
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
        @item = current_user.items.build(item_params)
        @item.category_id = params[:category_id]
        if @item.save
           flash[:success] = "Creating item success"
           redirect_to ur_stores_path
        else
            render 'new'
        end
    end

    def edit
        @categories = Category.all.map{ |c| [c.name, c.id] }
    end
    
    def destroy
        @item.destroy
        redirect_to ur_stores_path
    end

    private

    def item_params
        params.require(:item).permit(:code, :name, :description, :producer, :category_id, :item_img)
    end
    
    def find_item
        @item = Item.find(params[:id])
    end
end
