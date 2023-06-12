# itemsモデル
class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category
  belongs_to :item_condition
  belongs_to :item_postage
  belongs_to :prefecture
  belongs_to :shipping_day
  has_one_attached :image

  # 空の投稿を保存できないようにする
  validates :item_name, :item_description, :price, presence: true
  # 商品画像を1枚つけないと保存できないようにする
  validates :image, presence: true
  # 価格は、¥300~¥9,999,999の間以外は保存できないようにする
  # 価格は、半角数字以外は保存できないようにする
  validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 },
            format: { with: /\A[0-9]+\z/ }

  # ジャンルの選択が「---」の時は保存できないようにする
  validates :category_id, :item_condition_id, :item_postage_id, :prefecture_id, :shipping_day_id, numericality: { other_than: 1 }
end
