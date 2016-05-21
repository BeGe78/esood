class CreateRcharts < ActiveRecord::Migration
  def change
    create_table :rcharts do |t|
      t.string :country
      t.string :yearstart
      t.string :yearend

      t.timestamps null: false
    end
  end
end
