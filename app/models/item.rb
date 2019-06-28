class Item < ApplicationRecord
    before_destroy :not_referenced_by_any_order_item
    belongs_to :user, optional: true
    belongs_to :category
    has_many :reviews
    has_many :order_items, dependent: :destroy
    has_many :variants, class_name: 'ItemVariant'
    
    has_attached_file :item_img, styles: { item_index: "250x350>", item_show: "325x475>"}
    validates_attachment_content_type :item_img, content_type: /\Aimage\/.*\Z/

    default_scope { where(active: true) }

    private

    def not_referenced_by_any_order_item
        unless order_items.empty?
            errors.add(:base, "order item present!")
            throw :abort
        end      
    end
end
