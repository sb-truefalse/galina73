class CreateTelegramsMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :telegrams_messages do |t|
      t.bigint :tg_message_id
      t.bigint :tg_from_id
      t.integer :date
      t.bigint :tg_chat_id
      t.json :data

      t.timestamps
    end
  end
end
