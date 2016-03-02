now = Time.now
a_year_ago = now - (60*60*24*365)
a_year_from_now = now + (60*60*24*365)
random_time1 = rand(a_year_ago..a_year_from_now)
random_time2 = random_time1 + (60*60*rand(1..10))
FactoryGirl.define do
  factory :event do
  	uid FFaker::Guid.guid

  	description FFaker::HipsterIpsum.paragraph

  	url FFaker::Internet.http_url
  	image_url FFaker::Internet.http_url
  	fb_url FFaker::Internet.http_url
  	ticketing_url FFaker::Internet.http_url

    free false
    price rand(1..20)

    start_time random_time1
    end_time random_time2
    duration (random_time1 - random_time2)
    time_zone FFaker::AddressUS.time_zone

  end

end
