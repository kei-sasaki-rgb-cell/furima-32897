FactoryBot.define do
  factory :form_obj do
    postcode { '000-0000' }
    prefecture_id { 2 }
    city { '秋田県秋田市雄戸沢字後絵他' }
    block { '00' }
    building { '柳ビル' }
    phone_number { '00000000000' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
