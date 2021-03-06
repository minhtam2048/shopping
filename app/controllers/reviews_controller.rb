class ReviewsController < ApplicationController
    before_action :find_item
    before_action :find_review, only: [:edit, :update, :destroy]
    before_action :authenticate_user!, only: [:new, :edit]

    def new
        @review = Review.new
    end

    def create
        @review = Review.new(review_params)
        @review.item_id = @item.id
        @review.user_id = current_user.id
        
        # if @review.save
        #     redirect_to item_path(@item)
        # else
        #     render 'new'
        # end

        respond_to do |format|
            if @review.save
            format.js
            format.html { redirect_to item_path(@item)}
            else
                format.html { render :new}
            end
        end
    end


    def edit
    end

    def update
        
        if @review.update(review_params)
            redirect_to item_path(@item)
        else 
            render 'edit'
        end
    end


    def destroy
        @review.destroy
        redirect_to item_path(@item)
    end

    private

    def review_params
        params.require(:review).permit(:rating, :comment)
    end

    def find_item
        @item = Item.find(params[:item_id])
    end

    def find_review
        @review = Review.find(params[:id])
    end
end
