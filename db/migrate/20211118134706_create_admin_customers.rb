class CreateAdminCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_customers do |t|

      t.timestamps
    end
  end
end
