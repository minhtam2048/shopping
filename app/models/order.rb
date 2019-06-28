class Order < ApplicationRecord
    belongs_to :order_status
    belongs_to :user
    has_many :order_items, dependent: :destroy
    has_many :items, through: :order_items
    enum status: [:pending, :accepted, :refused]

    before_create :update_status
    before_save :update_total
    
    def calculate_total
        self.order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price ) : 0}.sum        
    end
    
    private

    def update_status
        if self.status == nil
            self.status = "In progress"
    end

    def update_total
        self[:subtotal] = subtotal
    end
end
