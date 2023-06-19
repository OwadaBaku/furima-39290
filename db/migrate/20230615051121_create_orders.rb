class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.bigint :user_id, null: false
      t.bigint :item_id, null: false
      t.timestamps
    end
  end
end
