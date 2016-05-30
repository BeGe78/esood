class AddVisibleToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :visible, :string
  end
end
