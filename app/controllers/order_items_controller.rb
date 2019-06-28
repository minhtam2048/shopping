class OrderItemsController < ApplicationController
    before_action :authenticate_user!, :load_order, only: %i(index) 
	
	def index
		@order_items = @order.order_items.all
	end
	
	private
	
	def load_order
		@order = current_user.orders.find_by id: params[:order_id]
		return if @order
		flash[:danger] =  "not_found_order"
		redirect_to orders_path
	end
    
end
