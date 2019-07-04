class Item < ApplicationRecord
    before_destroy :not_referenced_by_any_line_item
    belongs_to :ur_store, optional: true
    belongs_to :category
    has_many :line_items
    has_one :user, through: :store
    has_many :reviews
    
    
    has_attached_file :item_img, styles: { item_index: "250x350>", item_show: "325x475>"}
    validates_attachment_content_type :item_img, content_type: /\Aimage\/.*\Z/

    default_scope { where(active: true) }

    private

    def not_referenced_by_any_line_item
        unless line_items.empty?
            errors.add(:base, "line items present!")
            throw :abort
        end      
    end
end
