FactoryBot.define do
  factory :item do
    association :user
    product_name { Faker::Name.initials(number: 2) }
    description { Faker::Lorem.sentence }
    category_id { 2 }
    status_id { 2 }
    charge_id { 2 }
    prefecture_id { 2 }
    delivery_day_id { 2 }
    price { 2000 }
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
