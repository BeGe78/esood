class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :id1
      t.string :iso2code
      t.string :code
      t.string :name
      t.string :type

      t.timestamps null: false
    end
  end
end
