class Item < ApplicationRecord
    belongs_to :user
    belongs_to :category
    has_many :reviews

    has_attached_file :item_img, styles: { item_index: "250x350>", item_show: "325x475>"}
    validates_attachment_content_type :item_img, content_type: /\Aimage\/.*\Z/
end
