module CartsHelper
    def total_price(order_items)
        total = 0
        order_items.each do |item|
          total += calc_price item.product_price, item.quantity
        end
        total
      end
end
