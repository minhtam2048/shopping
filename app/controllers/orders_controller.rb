class OrdersController < ApplicationController

  before_action :load_order, only: [:update, :show, :destroy]
  before_action :load_orders, only: :index
  before_action :load_list_product, only: :new
  

    def new
       if user_signed_in?
          @order = Order.new
        else
          flash[:warning] = "you must sign in"
          redirect_to user_sign_in_path
         end
    end

    def index 
      @user = User.find(params[:user_id])
      @orders = @user.orders
    end

    def create
        @order = Order.new(order_params)
        items =  get_orders
        result = false
        result1 = false
        
        if items.present?
            
    end


end
