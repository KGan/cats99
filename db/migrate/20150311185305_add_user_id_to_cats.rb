class AddUserIdToCats < ActiveRecord::Migration
  def change
    add_column :cats, :user_id, :integer, index: true, null: false, default: 0
  end
end
