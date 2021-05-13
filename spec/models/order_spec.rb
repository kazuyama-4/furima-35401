require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '購入' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order = FactoryBot.build(:order, user_id: user.id, item_id: item.id)
      sleep 0.1
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば購入できること' do
        expect(@order).to be_valid
      end
      it 'buildingは空でも購入できること' do
        @order.building = ''
        expect(@order).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postalが空だと購入できないこと' do
        @order.postal = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Postal can't be blank",
                                                       'Postal is invalid. Enter it as follows(e.g. 123-4567)')
      end
      it 'postalが半角のハイフンを含んだ正しい形式でないと購入できないこと' do
        @order.postal = 1_234_567
        @order.valid?
        expect(@order.errors.full_messages).to include('Postal is invalid. Enter it as follows(e.g. 123-4567)')
      end
      it 'prefecture_idを選択していないと購入できないこと' do
        @order.prefecture_id = 1
        @order.valid?
        expect(@order.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityは空では購入できないこと' do
        @order.city = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("City can't be blank")
      end
      it 'house_numberは空でも購入できないこと' do
        @order.house_number = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("House number can't be blank")
      end
      it 'call_numberが空では購入できないこと' do
        @order.call_number = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Call number can't be blank", 'Call number is too short',
                                                       'Call number is invalid. Input only number')
      end
      it 'call_numberが11桁以下の場合、購入できないこと' do
        @order.call_number = '0901234567'
        @order.valid?
        expect(@order.errors.full_messages).to include('Call number is too short')
      end
      it 'call_numberが9桁以内の場合、購入できないこと' do
        @order.call_number = '090123456'
        @order.valid?
        expect(@order.errors.full_messages).to include('Call number is too short')
      end
      it 'call_numberが12桁以上の場合、購入できないこと' do
        @order.call_number = '090123456789'
        @order.valid?
        expect(@order.errors.full_messages).to include('Call number is too long')
      end
      it 'call_numberが数字ではないと購入できないこと' do
        @order.call_number = '零九零一二三四五六七八'
        @order.valid?
        expect(@order.errors.full_messages).to include('Call number is too short',
                                                       'Call number is invalid. Input only number')
      end
      it 'tokenが空では購入できないこと' do
        @order.token = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Token can't be blank")
      end
      it 'userが空では購入できないこと' do
        @order.user_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが空では購入できないこと' do
        @order.item_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
