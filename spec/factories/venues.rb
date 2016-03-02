FactoryGirl.define do
  factory :venue do
  	name FFaker::Address.street_name
    address FFaker::AddressUS.street_address
    city FFaker::AddressUS.city
    state FFaker::AddressUS.state
    country FFaker::AddressUS.country
    postal_code FFaker::AddressUS.zip_code
    phone_number FFaker::PhoneNumber.phone_number
    email FFaker::Internet.email
    url FFaker::Internet.http_url
  end

end
