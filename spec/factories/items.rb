FactoryBot.define do
  factory :item do
    name { '玉子' }
    description { '玉子です' }
    category_id { 2 }
    state_id { 2 }
    postage_id { 2 }
    prefecture_id { 2 }
    shipping_date_id { 2 }
    price { 300 }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/furima_test_img.png'), filename: 'furima_test_img.png')
    end
  end
end
