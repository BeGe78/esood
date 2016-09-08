class AddFakesToSelectors < ActiveRecord::Migration
  def change
      add_column :selectors, :fake_indicator, :string
      add_column :selectors, :fake_indicator2, :string
      add_column :selectors, :fake_country1, :string
      add_column :selectors, :fake_country2, :string
  end
end
