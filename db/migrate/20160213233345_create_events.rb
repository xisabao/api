class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
    	t.string :region
    	t.string :country
    	t.string :type
    	t.string :subtype
    	t.text :description
    	t.text :details
    	t.string :link
    	t.text :categories
    	t.text :tags

    	t.string :phone_number
    	t.boolean :family_friendly

    	t.datetime :start_time
    	t.datetime :end_time
    	t.integer :duration
    	t.datetime :ticket_deadline
   		t.boolean :tickets_required
    	t.float :cost
    	t.boolean :free

    	t.string :contact_name
    	t.integer :organizer_id
    	t.integer :venue_id

      t.timestamps null: false
    end
  end
end
