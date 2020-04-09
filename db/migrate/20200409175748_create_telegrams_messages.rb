class CreateTelegramsMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :telegrams_messages do |t|
      t.bigint :message_id
      t.bigint :from_id
      t.integer :date
      t.bigint :chat_id
      t.json :data

      t.timestamps
    end
  end
end
