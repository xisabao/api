FactoryGirl.define do
  factory :organizer do
    name FFaker::Name.name
  	address FFaker::AddressUS.street_address
  	city FFaker::AddressUS.city
    state FFaker::AddressUS.state
    country FFaker::AddressUS.country
    postal_code FFaker::AddressUS.zip_code
    phone_number FFaker::PhoneNumber.phone_number
    url FFaker::Internet.http_url
    email FFaker::Internet.email
  end

end
