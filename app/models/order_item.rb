class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item 

  delegate :quantity, to: :item, prefix: :item, allow_nil: true

  validate :item_present
  validate :order_present
  
  before_save :finalize
  
  before_destroy :return_quantity_when_refuse
  
  

  def unit_price
    if persisted?
      self[:unit_price]
    else
      item.price
    end
  end

  def total_price
    unit_price * quantity
  end

private
  def item_present
    if item.nil?
      errors.add(:item, "is not valid or is not active.")
    end
  end

  def order_present
    if order.nil?
      errors.add(:order, "is not a valid order.")
    end
  end

  def return_quantity_when_refuse
    item.update_attribute :quantity, item_quantity + quantity if order.pending? || order.refuse? 
  end

  def finalize
    self[:unit_price] = unit_price
    self[:total_price] = quantity * self[:unit_price]
  end
end
