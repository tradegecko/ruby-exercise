FactoryGirl.define do
  factory :gif do
    url 'http://media3.giphy.com/media/LizJ8r4pDrzmE/giphy.gif'
    keyword 'hello'
    created_at Time.zone.now
  end
end