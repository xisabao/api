require 'spec_helper'

RSpec.describe Venue, type: :model do
    describe Venue do
	  	before { @venue = FactoryGirl.build(:venue)}
	  	subject { @venue }

	  	it { should respond_to(:name) }

	  	it { should respond_to(:address) }
	  	it { should respond_to(:postal_code) }
	  	it { should respond_to(:city) }
	  	it { should respond_to(:state) }
	  	it { should respond_to(:country) }

	  	it { should respond_to(:phone_number) }
	  	it { should respond_to(:email) }

	  	it { should respond_to(:url) }
	  	
	  	it { should have_many(:events) }

	  	it { should be_valid }
  end
end
