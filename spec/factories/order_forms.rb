FactoryBot.define do
  factory :order_form do
    postcode      {'123-1234'}
    prefecture_id {4}
    city          {'東京都'}
    house_number  {'渋谷区'}
    building_name {'アジアビル'}
    phone_number  {'12312341234'}
    token         {'tok_abcdefghijk00000000000000000'}
    item_id       {1}
    user_id       {1}
  end
end
