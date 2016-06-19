class AddIndicator2ToSelectors < ActiveRecord::Migration
  def change
    add_column :selectors, :indicator2, :string
  end
end
