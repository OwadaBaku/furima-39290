FactoryBot.define do
  factory :item do
    item_name        { 'test' }
    item_description { 'これはテストです。' }
    category_id      { 2 }
    item_condition_id { 2 }
    item_postage_id  { 2 }
    prefecture_id    { 2 }
    shipping_day_id  { 2 }
    price            { '500' }

    user # userとのアソシエーション

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/a.png'), filename: 'a.png')
    end
  end
end
