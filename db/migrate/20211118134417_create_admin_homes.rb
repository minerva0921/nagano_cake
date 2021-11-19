class CreateAdminHomes < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_homes do |t|

      t.timestamps
    end
  end
end
