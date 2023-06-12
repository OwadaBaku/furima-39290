require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
      context '出品できるとき' do
        it 'image_id、item_name、item_description、category_id、item_condition_id、item_postage_id、prefecture_id、shipping_day_id、priceが存在すれば登録できる' do
          expect(@item).to be_valid
        end
      end
      context '出品できないとき' do
        it 'imageがないと出品できない' do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include "Image can't be blank"
        end

        it 'item_name がないと出品できない' do
          @item.item_name = ''
          @item.valid?
          expect(@item.errors.full_messages).to include "Item name can't be blank"
        end

        it 'item_descriptionがないと出品できない' do
          @item.item_description = ''
          @item.valid?
          expect(@item.errors.full_messages).to include "Item description can't be blank"
        end

        it 'category_idがないと出品できない' do
          @item.category_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include "Category is not a number"
        end

        it 'item_condition_idがないと出品できない' do
          @item.item_condition_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include "Item condition is not a number"
        end

        it 'item_postage_idがないと出品できない' do
          @item.item_postage_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include "Item postage is not a number"
        end

        it 'prefecture_idがないと出品できない' do
          @item.prefecture_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include "Prefecture is not a number"
        end

        it 'shipping_day_idがないと出品できない' do
          @item.shipping_day_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include "Shipping day is not a number"
        end

        it 'priceがないと出品できない' do
          @item.price = ''
          @item.valid?
          expect(@item.errors.full_messages).to include "Price can't be blank"
        end
        it 'priceが¥300~¥9,999,999の間以外だと出品できない' do
          # priceが300より少ない場合場合、出品できないことを検証
          @item.price = 299
          @item.valid?
          expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
          # priceが9,999,999を超える場合、出品できないことを検証
          @item.price = 10_000_000
          @item.valid?
          expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
        end
        it 'priceが半角数値以外の場合出品できない' do
          #priceが全角数字の場合
          @item.price = '５００'
          @item.valid?
          unless @item.price =~ /\A[0-9]+\z/
            expect(@item.errors.full_messages).to include 'Price is not a number'
          end
        end
      end
    end
  end
# bundle exec rspec spec/models/item_spec.rb