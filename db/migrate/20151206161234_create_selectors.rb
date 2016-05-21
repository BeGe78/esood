class CreateSelectors < ActiveRecord::Migration
  def change
    create_table :selectors do |t|
      t.string :indicator
      t.string :country1
      t.string :country2
      t.string :period

      t.timestamps null: false
    end
  end
end
