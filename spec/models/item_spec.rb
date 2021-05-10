require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '出品' do
    context '出品できる場合' do
      it '全て記入したら出品できる' do
        expect(@item).to be_valid
      end
    end

    context '出品できない場合' do
      it '画像が空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が空では出品できない' do
        @item.product_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product name can't be blank")
      end
      it '商品説明が空では出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'カテゴリーを選んでないと出品できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Category Select')
      end
      it '1が選択されている場合は出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category Select')
      end
      it '商品状態を選んでないと出品できない' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Status Select')
      end
      it '1が選択されている場合は出品できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Status Select')
      end
      it '配送料の負担を選んでないと出品できない' do
        @item.charge_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Charge Select')
      end
      it '1が選択されている場合は出品できない' do
        @item.charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Charge Select')
      end
      it '発送元の地域を選んでないと出品できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture Select')
      end
      it '1が選択されている場合は出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture Select')
      end
      it '発送日数を選んでないと出品できない' do
        @item.delivery_day_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery day Select')
      end
      it '1が選択されている場合は出品できない' do
        @item.delivery_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery day Select')
      end
      it '販売価格が空では出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '販売価格が半角数字で入力しないと出品できない' do
        @item.price = '３０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Half-width number')
      end
      it '販売価格を超えた場合(300円より低い場合)、出品できない' do
        @item.price = 200
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end
      it '販売価格を超えた場合(9999999円を超えた場合)、出品できない' do
        @item.price = 100_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range')
      end
    end
  end
end