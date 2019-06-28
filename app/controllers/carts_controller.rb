class CartsController < ApplicationController
    before_action :load_product, only: [:create, :destroy, :update]
    before_action :current_order, only: [:show]

    def show
        @order_items = []
        sessions[:shopping_cart].each do |item|
            @order_items << OrderItem.new(item)
        end    
    end              
    
    def create
        order_item = OrderItem.new(item_params)
        result = find_item_in_cart(order_item.item_id)
        if order_item.quantity.nil? || order_item.quantity <= 0
          respond_to do |format|
            format.js
          end
        elsif result
          check_quantity result, order_item.quantity
        else
          session[:shopping_cart] << order_item
          respond_to do |format|
            format.js
          end
        end
        order_item.price =  (Item.find_by id: order_item.item_id).price
      end
    
    
      def update
        quantity = params[:quantity].to_i
        if quantity > @item.quantity || quantity <= 0
          flash[:danger] = "invalid_quantity"
        else
          result = find_item_in_cart(@item.id)
          result["quantity"] = quantity
        end
        redirect_to cart_path
      end
    
      def destroy
        session[:shopping_cart].each do |item|
        session[:shopping_cart].delete(item) if item["item_id"] == @item.id
        end
        flash[:success] = "success_delete"
        redirect_to cart_path
      end
    
      private
    
      def item_params
        params.permit :item_id, :quantity, :price
      end
    
      def load_product
        current_order
        @item = Item.find_by id: params[:product_id]
        return if @item
        flash[:danger] =  "not_found_product"
        redirect_to root_path
      end
    
      def find_item_in_cart(item_id)
        result = nil
        session[:shopping_cart].each do |item|
          next unless item["product_id"] == product_id
          result = item
        end
        result
      end
    
      def check_quantity result, quantity
        if result["quantity"] + quantity > @product.quantity
          flash[:danger] = t ".invalid_quantity"
        else
          result["quantity"] += quantity
        end
      end
end                                                                                 
                         