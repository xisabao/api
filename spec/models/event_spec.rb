require 'spec_helper'

RSpec.describe Event, type: :model do
  describe Event do
  	before { @event = FactoryGirl.build(:event)}
  	subject { @event }

  	it { should respond_to(:name) }
  	it { should respond_to(:uid) }
  	it { should respond_to(:description) }
  	it { should respond_to(:url) }
  	it { should respond_to(:image_url) }
  	it { should respond_to(:fb_url) }
  	it { should respond_to(:ticketing_url) }

  	it { should respond_to(:free) }
  	it { should respond_to(:price) }

  	it { should respond_to(:start_time) }
  	it { should respond_to(:end_time) }
  	it { should respond_to(:duration) }
  	it { should respond_to(:time_zone) }

  	it { should belong_to(:organizer) }
  	it { should belong_to(:venue) }


  	it { should be_valid }
  end
end
