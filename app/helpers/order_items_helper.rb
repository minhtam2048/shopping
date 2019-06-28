module OrderItemsHelper
    def calc_price unit_price, quantity
        unit_price * quantity.to_i
      end
end
