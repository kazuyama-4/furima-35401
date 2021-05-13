FactoryBot.define do
  factory :order do
    postal { '123-4567' }
    prefecture_id { 2 }
    city { '鎌倉市' }
    house_number { '1-1' }
    building { '鎌倉ハイツ' }
    call_number { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
