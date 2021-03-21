require 'rails_helper'

RSpec.describe Ship, type: :model do
  before do
    @ship = FactoryBot.build(:ship)
  end

  describe '商品購入情報' do
    context '商品を購入できる場合' do
      it '必須項目に全て記入、選択していれば購入できる' do
        expect(@ship).to be_valid
      end
    end

    context '商品が購入できない場合' do
      it '郵便番号がなければ購入できない'do
        @ship.postcode = nil
        @ship.valid?
        expect(@ship.errors.full_messages).to include("Postcode can't be blank")
      end
      it '郵便番号にはハイフンがないと購入できない' do
        @ship.postcode = '0000000'
        @ship.valid?
        expect(@ship.errors.full_messages).to include("Postcode is invalid")
      end
      it '発送元の地域の選択をしていなければ購入できない' do
        @ship.prefecture_id = 1
        @ship.valid?
        expect(@ship.errors.full_messages).to include('Prefecture must be other than 1')
      end
      it '市区町村の記述がなければ購入できない' do
        @ship.city = nil
        @ship.valid?
        expect(@ship.errors.full_messages).to include("City can't be blank")
      end
      it '番地がなければ購入できない' do
        @ship.block = nil
        @ship.valid?
        expect(@ship.errors.full_messages).to include("Block can't be blank")
      end
      it '電話番号がなければ購入できない' do
        @ship.phone_number = nil
        @ship.valid?
        expect(@ship.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号にハイフンなしでなければ購入できない' do
        @ship.phone_number = '-'
        @ship.valid?
        expect(@ship.errors.full_messages).to include("Phone number is invalid")
      end
      it '電話番号が11桁以内でないと購入できない' do
        @ship.phone_number = '0000000000'
        @ship.valid?
        expect(@ship.errors.full_messages).to include("Phone number is invalid")
      end
    end
  end
end