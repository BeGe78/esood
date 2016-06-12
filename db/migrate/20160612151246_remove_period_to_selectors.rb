class RemovePeriodToSelectors < ActiveRecord::Migration
  def change
    remove_column :selectors, :period, :string
  end
end
