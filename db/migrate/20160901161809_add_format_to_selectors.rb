class AddFormatToSelectors < ActiveRecord::Migration
  def change
      add_column :selectors, :format, :string
  end
end
