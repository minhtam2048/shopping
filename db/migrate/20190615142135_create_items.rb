class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :code
      t.string :name, null: false
      t.text :description
      t.string :producer
      t.integer :quantity, default: 1234
      t.decimal :price ,precision: 12, scale: 3, default: 10000
      t.boolean :active
      
      t.references :ur_store, foreign_key: true

      t.timestamps
    end
  end
end
