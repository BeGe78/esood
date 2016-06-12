class AddYearBeginToSelectors < ActiveRecord::Migration
  def change
    add_column :selectors, :year_begin, :integer
  end
end
