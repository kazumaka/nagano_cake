class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|

      t.integer :customer_id
      t.string :ship_postal_code
      t.string :ship_postal_address
      t.string :ship_name
      t.integer :request_money
      t.integer :payment
      t.integer :postage
      t.integer :status

      t.timestamps
    end
  end
end
