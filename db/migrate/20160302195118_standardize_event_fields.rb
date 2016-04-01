class StandardizeEventFields < ActiveRecord::Migration
  def change
  	rename_column :events, :start_time, :dstart
  	rename_column :events, :end_time, :dtend
  	rename_column :events, :fb_url, :fb_event_url
  	rename_column :events, :description, :body_text
  end
end
