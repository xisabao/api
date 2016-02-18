class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
    	t.integer :event_id
    	t.integer :user_id
    	t.boolean :success

      t.timestamps null: false
    end
  end
end
