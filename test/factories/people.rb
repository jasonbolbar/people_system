FactoryGirl.define do
  factory :person do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.free_email("#{first_name}.#{last_name}") }
    job { [Faker::Name.title, nil].sample }
    bio { Faker::Lorem.paragraph }
    gender { Person::GENDERS.keys.sample }
    birth_date { Faker::Date.between(50.years.ago, Date.today) }
    sequence(:picture) { |n| "http://imageserver.com/#{n}.png" }
  end
end
