class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_condition
  belongs_to :item_postage
  belongs_to :prefecture
  belongs_to :shipping_day

  # # 空の投稿を保存できないようにする
  # validates :item_name, :item_description, :price, presence: true

  # # ジャンルの選択が「---」の時は保存できないようにする
  # validates :category_id, :item_condition_id, :item_postage_id, :prefecture_id, :shipping_day_id, numericality: { other_than: 1, message: "can't be blank" }
end
