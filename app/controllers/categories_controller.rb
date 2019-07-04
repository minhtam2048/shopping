class CategoriesController < ApplicationController
    before_action :find_category, only: [:show, :update, :edit, :destroy]

    def index
      @q =Category.ransack(params[:id])
      @categories = @q.result.order("created_at DESC").page(params[:page])
     
      respond_to do |format|
            format.html
            format.js
        end 
    end

    def show
        
      # @items = @category.items
      @items = Item.where(category_id: @category.id)    
    end

    def new
        @category = Category.new
    end

    def create 
        @category = Category.new(category_params)
        if @category.save
            flash[:info] = "Adding Category Success!"
            redirect_to action: "index"
        else    
            redirect_to new
        end
    end

    def edit; end
    

  def update
    if @category.update_attributes(category_params)
      flash[:success] = "Category updated"
      redirect_to @category
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
        format.js
    end
  end

  private 
  
  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end

