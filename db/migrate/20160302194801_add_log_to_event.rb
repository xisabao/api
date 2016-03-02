class AddLogToEvent < ActiveRecord::Migration
  def change
  	add_column :events, :log, :text
  end
end
