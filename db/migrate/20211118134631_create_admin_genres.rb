class CreateAdminGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_genres do |t|

      t.timestamps
    end
  end
end
