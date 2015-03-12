class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name, null: false, unique: true, index: true
      t.string :password_digest
      t.string :session_token, null: false, unique: true, index: true

      t.timestamps null: false
    end
  end
end
