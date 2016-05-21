class CreateIndicators < ActiveRecord::Migration
  def change
    create_table :indicators do |t|
      t.text :id1
      t.text :name
      t.text :language
      t.text :source
      t.text :topic
      t.text :note

      t.timestamps null: false
    end
  end
end
