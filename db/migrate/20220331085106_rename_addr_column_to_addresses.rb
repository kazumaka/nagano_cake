class RenameAddrColumnToAddresses < ActiveRecord::Migration[6.1]
  def change
    rename_column :addresses, :addr, :address
  end
end
