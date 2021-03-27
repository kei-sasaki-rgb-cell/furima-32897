require 'rails_helper'

RSpec.describe FormObj, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @form_obj = FactoryBot.build(:form_obj, user_id: @user.id, item_id: @item.id)
    sleep 1
  end

  describe '商品購入情報' do
    context '商品を購入できる場合' do
      it '必須項目に全て記入、選択していれば購入できる' do
        expect(@form_obj).to be_valid
      end
      it '建物名がなくても購入できる' do
        @form_obj.building = nil
        expect(@form_obj).to be_valid
      end
    end

    context '商品が購入できない場合' do
      it '郵便番号がなければ購入できない' do
        @form_obj.postcode = nil
        @form_obj.valid?
        expect(@form_obj.errors.full_messages).to include("Postcode can't be blank")
      end
      it '郵便番号にはハイフンがないと購入できない' do
        @form_obj.postcode = '0000000'
        @form_obj.valid?
        expect(@form_obj.errors.full_messages).to include('Postcode is invalid')
      end
      it '発送元の地域の選択をしていなければ購入できない' do
        @form_obj.prefecture_id = 1
        @form_obj.valid?
        expect(@form_obj.errors.full_messages).to include('Prefecture must be other than 1')
      end
      it '市区町村の記述がなければ購入できない' do
        @form_obj.city = nil
        @form_obj.valid?
        expect(@form_obj.errors.full_messages).to include("City can't be blank")
      end
      it '番地がなければ購入できない' do
        @form_obj.block = nil
        @form_obj.valid?
        expect(@form_obj.errors.full_messages).to include("Block can't be blank")
      end
      it '電話番号がなければ購入できない' do
        @form_obj.phone_number = nil
        @form_obj.valid?
        expect(@form_obj.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号にハイフンなしでなければ購入できない' do
        @form_obj.phone_number = '-'
        @form_obj.valid?
        expect(@form_obj.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が11桁以内でないと購入できない' do
        @form_obj.phone_number = '0000000000'
        @form_obj.valid?
        expect(@form_obj.errors.full_messages).to include('Phone number is invalid')
      end
      it 'tokenが空では登録できないこと' do
        @form_obj.token = nil
        @form_obj.valid?
        expect(@form_obj.errors.full_messages).to include("Token can't be blank")
      end
      it 'user_idが空では登録できないこと' do
        @form_obj.user_id = nil
        @form_obj.valid?
        expect(@form_obj.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空では登録できないこと' do
        @form_obj.item_id = nil
        @form_obj.valid?
        expect(@form_obj.errors.full_messages).to include("Item can't be blank")
      end
      it '電話番号は英数混合では登録できない' do
        @form_obj.phone_number = 'd0000000000'
        @form_obj.valid?
        expect(@form_obj.errors.full_messages).to include("Phone number is invalid")
      end
    end
  end
end
