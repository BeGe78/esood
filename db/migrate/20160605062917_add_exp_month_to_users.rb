class AddExpMonthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :exp_month, :string
  end
end
