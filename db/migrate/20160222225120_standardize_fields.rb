class StandardizeFields < ActiveRecord::Migration
  def change
  	rename_column :events, :cost, :price
  	add_column :events, :timezone, :string
  	rename_column :events, :link, :url
  	rename_column :organizers, :link, :url
  	rename_column :venues, :link, :url
  	add_column :events, :image_url, :string
  	add_column :events, :ticketing_url, :string
  end
end
