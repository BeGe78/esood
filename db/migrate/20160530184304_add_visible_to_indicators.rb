class AddVisibleToIndicators < ActiveRecord::Migration
  def change
    add_column :indicators, :visible, :string
  end
end
