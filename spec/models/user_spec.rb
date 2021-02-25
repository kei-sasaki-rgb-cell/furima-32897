require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録/ユーザー情報' do
    context '正常系テスト' do
      it '入力された値に問題がなく登録できること' do
        expect(@user.valid?).to eq true
      end
      it 'パスワードは、確認用を含めて2回入力することで登録できる' do
        @user.password = '000b00'
        @user.password_confirmation = '000b00'
        expect(@user).to be_valid
      end
      it 'パスワードとパスワード（確認用）、値が一致していれば登録できる' do
        @user = FactoryBot.build(:user)
        @user.password == @user.password_confirmation
        expect(@user).to be_valid
      end
      it 'ユーザー本名は、名字と名前がそれぞれあれば登録できる' do
        @user = FactoryBot.build(:user)
        @user.last_name = '全角'
        @user.first_name = '太郎'
        @user.valid?
        expect(@user).to be_valid
      end
      it 'ユーザー本名は、全角（漢字・ひらがな・カタカナ）での入力があれば保存できる' do
        @user = FactoryBot.build(:user)
        @user.last_name = '全角'
        @user.first_name = '太郎'
        @user.valid?
        expect(@user).to be_valid
      end
      it 'ユーザー本名のフリガナは、名字と名前があれば登録できる' do
        @user = FactoryBot.build(:user)
        @user.last_name_kana = 'ゼンカク'
        @user.first_name_kana = 'タロウ'
        @user.valid?
        expect(@user).to be_valid
      end
      it 'ユーザー本名のフリガナは、全角（カタカナ）での入力があれば登録できる' do
        @user = FactoryBot.build(:user)
        @user.last_name_kana = 'ゼンカク'
        @user.first_name_kana = 'タロウ'
        @user.valid?
        expect(@user).to be_valid
      end
      it '生年月日が記入されていれば登録できる' do
        @user = FactoryBot.build(:user)
        @user.birthday = '2000-01-01'
        @user.valid?
        expect(@user).to be_valid
      end
    end

    context '異常系テスト' do
      it 'nicknameが空では登録できない' do
        @user = FactoryBot.build(:user)
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが一意性（重複してはならない)でなければ登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスは、@を含めないと登録できない' do
        @user.email = '@'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが空だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードは、5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードは、半角英数字混合での入力でなければ登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
    end
  end
end
