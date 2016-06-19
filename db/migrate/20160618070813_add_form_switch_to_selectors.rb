class AddFormSwitchToSelectors < ActiveRecord::Migration
  def change
    add_column :selectors, :form_switch, :string
  end
end
