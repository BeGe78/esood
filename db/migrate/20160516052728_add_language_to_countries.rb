class AddLanguageToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :language, :text
  end
end
