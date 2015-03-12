class AddUserIdToUsers < ActiveRecord::Migration
  def change
    add_column :cat_rental_requests, :user_id, :integer, null: false, default: 0, index: true
  end

end
