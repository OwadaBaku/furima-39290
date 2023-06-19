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
  has_one :order

  # 空の投稿を保存できないようにする
  validates :item_name, :item_description, :price, presence: true
  # 商品画像を1枚つけないと保存できないようにする
  validates :image, presence: true
  # 価格は、半角数字で¥300~¥9,999,999の間以外は保存できないようにする
  # 価格は、数字保存できないようにする
  validates :price, numericality: { only_integer: true }, inclusion: { in: 300..9_999_999 }
  # ジャンルの選択が「---」の時は保存できないようにする
  validates :category_id, :item_condition_id, :item_postage_id, :prefecture_id, :shipping_day_id, numericality: { other_than: 1 }

  def sold_out?
    Order.exists?(item_id: id)
  end
end
