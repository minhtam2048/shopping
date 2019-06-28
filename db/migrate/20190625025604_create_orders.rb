class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
     
      t.column :total_price, :decimal
      t.integer :status, default: 0
      t.references :order_status, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
