class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.integer :sender_id
      t.integer :recipent_id

      t.timestamps
    end

    add_index :conversations, :sender_id
    add_index :conversations, :recipent_id
  end
end
