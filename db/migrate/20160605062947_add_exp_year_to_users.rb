class AddExpYearToUsers < ActiveRecord::Migration
  def change
    add_column :users, :exp_year, :string
  end
end
