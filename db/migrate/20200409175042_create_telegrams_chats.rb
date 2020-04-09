class CreateTelegramsChats < ActiveRecord::Migration[6.0]
  def change
    create_table :telegrams_chats do |t|
      t.bigint :tg_chat_id
      t.integer :tg_type
      t.string :title
      t.string :username
      t.string :first_name
      t.string :last_name
      t.boolean :all_members_are_administrators

      t.timestamps
    end
  end
end
