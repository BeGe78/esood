class AddInvoiceCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :invoice_count, :integer
  end
end
