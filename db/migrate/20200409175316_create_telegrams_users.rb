class CreateTelegramsUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :telegrams_users do |t|
      t.bigint :tg_user_id
      t.string :first_name
      t.string :last_name
      t.string :username

      t.timestamps
    end
  end
end
