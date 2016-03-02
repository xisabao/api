class AddLocationFieldsToOrganizer < ActiveRecord::Migration
  def change
  	add_column :organizers, :postal_code, :string
  	add_column :organizers, :city, :string
  	add_column :organizers, :state, :string
  	add_column :organizers, :country, :string
  end
end
