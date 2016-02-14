class CreateOrganizers < ActiveRecord::Migration
  def change
    create_table :organizers do |t|
 			t.string :name
 			t.string :address
 			t.string :phone_number
 			t.string :email
 			t.string :link

      t.timestamps null: false
    end
  end
end
