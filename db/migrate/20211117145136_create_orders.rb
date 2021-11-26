class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|

      t.integer :customer_id
      t.string :postal_code
      t.string :address
      t.string :name
      t.integer :postage
      t.integer :payment_method, default: 0
      t.integer :billing_amount
      t.integer :status, default: 0
      
      t.timestamps
    end
  end
end
