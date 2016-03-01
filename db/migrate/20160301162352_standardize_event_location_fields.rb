class StandardizeEventLocationFields < ActiveRecord::Migration
  def change
  	rename_column :events, :region, :state
  	add_column :events, :city, :string
  	add_column :events, :postal_code, :integer
  	add_column :events, :address, :string
  end
end
