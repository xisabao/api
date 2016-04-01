now = Time.now
a_year_ago = now - (60*60*24*365)
a_year_from_now = now + (60*60*24*365)
random_time1 = Random.rand(a_year_ago..a_year_from_now)
random_time2 = random_time1 + (60*60*Random.rand(1..10))
FactoryGirl.define do
  factory :event do
  	uid FFaker::Guid.guid

  	body_text FFaker::HipsterIpsum.paragraph

  	url FFaker::Internet.http_url
  	image_url FFaker::Internet.http_url
  	fb_event_url FFaker::Internet.http_url
  	ticketing_url FFaker::Internet.http_url

    free false
    price 5

    dstart random_time1
    dtend random_time2
    duration (random_time1 - random_time2)
    timezone FFaker::AddressUS.time_zone

  end

end
