require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    @order_form = FactoryBot.build(:order_form)
  end

  context '商品購入' do
    context '購入できるとき' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@order_form).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'tokenが空だと保存できない' do
        @order_form.token = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include "Token can't be blank"
      end

      it 'user_idが空だと保存できない' do
        @order_form.user_id = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include "User can't be blank"
      end

      it 'item_idが空だと保存できない' do
        @order_form.item_id = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include "Item can't be blank"
      end

      it 'postcodeが空だと保存できない' do
        @order_form.postcode = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include "Postcode can't be blank"
      end
      it 'Postcodeがハイフンを含まない形式では保存できないこと' do
        @order_form = FactoryBot.build(:order_form, postcode: '1234567')
        @order_form.valid?
        expect(@order_form.errors[:postcode]).to include 'is invalid. Enter it as follows (e.g. 123-4567)'
      end
      it 'Postcodeが指定の形式になっていない場合は保存できないこと（末尾が5桁の場合）' do
        @order_form = FactoryBot.build(:order_form, postcode: '123-456')
        @order_form.valid?
        expect(@order_form.errors[:postcode]).to include 'is invalid. Enter it as follows (e.g. 123-4567)'
      end
      it 'Postcodeが指定の形式になっていない場合は保存できないこと（先頭が2桁の場合）' do
        @order_form = FactoryBot.build(:order_form, postcode: '12-3456')
        @order_form.valid?
        expect(@order_form.errors[:postcode]).to include 'is invalid. Enter it as follows (e.g. 123-4567)'
      end

      it 'prefecture_idが空だと保存できない' do
        @order_form.prefecture_id = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include "Prefecture can't be blank"
      end

      it 'cityが空だと保存できない' do
        @order_form.city = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include "City can't be blank"
      end

      it 'house_numberが空だと保存できない' do
        @order_form.house_number = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include "House number can't be blank"
      end

      it 'phone_numberが空だと保存できない' do
        @order_form.phone_number = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include "Phone number can't be blank"
      end
      it 'phone_numbeが10桁以上11桁以内出ないと保存できない(9桁の場合)' do
        @order_form.phone_number = '123456789'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include 'Phone number is too short'
      end
    end
  end
end
