class AddYearEndToSelectors < ActiveRecord::Migration
  def change
    add_column :selectors, :year_end, :integer
  end
end
