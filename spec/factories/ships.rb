FactoryBot.define do
  factory :ship do
    postcode { '000-0000' }
    prefecture_id { 2 }
    city { '秋田県秋田市雄戸沢字後絵他' }
    block { '00' }
    phone_number { '00000000000' }
    association :buyer
  end
end
