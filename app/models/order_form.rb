class OrderForm
	include ActiveModel::Model
	attr_accessor :token, :user_id, :item_id, :postcode, :prefecture_id, :city, :house_number, :building_name, :phone_number

	with_options presence: true do
			validates :user_id
			validates :item_id
			validates :postcode, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)" }
			validates :prefecture_id, numericality: { other_than: 1 }
			validates :city
			validates :house_number
			validates :phone_number, numericality: { only_integer: true, message: "is invalid. Input only numbers" }, length: { in: 10..11, message: "is too short" }
			validates :token
		end

	def save
		order = Order.create(user_id: user_id, item_id: item_id)
		Payment.create(postcode: postcode, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number, order_id: order.id)
	end
end