class AddLocationFieldsToVenue < ActiveRecord::Migration
  def change
  	add_column :venues, :postal_code, :string
  	add_column :venues, :city, :string
  	add_column :venues, :state, :string
  	add_column :venues, :country, :string
  	change_column :events, :postal_code, :string
  end
end
