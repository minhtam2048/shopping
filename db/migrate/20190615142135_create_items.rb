class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :code
      t.string :name
      t.text :description
      t.string :producer
      t.timestamps
    end
  end
end
