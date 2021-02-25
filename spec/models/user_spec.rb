require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録/ユーザー情報' do
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
    it 'メールアドレスが一意性（重複してはならない）であること' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      # binding.pry
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
    it 'メールアドレスは、@を含めないと登録できない' do
      @user.email = '@'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end
    it 'パスワードが必須であること' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'パスワードは、6文字以上での入力が必須であること' do
      @user.password = '000a00'
      @user.password_confirmation = '000a00'
      expect(@user).to be_valid
    end
    it 'パスワードは、半角英数字混合での入力が必須であること' do
      @user.password = '000b00'
      @user.password_confirmation = '000b00'
      expect(@user).to be_valid
    end
    it 'パスワードは、確認用を含めて2回入力すること' do
      @user.password = '000b00'
      @user.password_confirmation = '000b00'
      expect(@user).to be_valid
    end
    it 'パスワードとパスワード（確認用）、値の一致が必須であること' do
      @user = FactoryBot.build(:user)
      @user.password == @user.password_confirmation
      expect(@user).to be_valid
    end
  end

  describe '新規登録/本人確認情報' do
    it 'ユーザー本名は、名字と名前がそれぞれ必須であること' do
      @user = FactoryBot.build(:user)
      @user.last_name = ''
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name can't be blank", 'Last name is invalid'
    end
    it 'ユーザー本名は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user = FactoryBot.build(:user)
      @user.last_name = '全角'
      @user.first_name = '太郎'
      @user.valid?
      expect(@user).to be_valid
    end
    it 'ユーザー本名のフリガナは、名字と名前でそれぞれ必須であること' do
      @user = FactoryBot.build(:user)
      @user.last_name_kana = ''
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name kana can't be blank", 'Last name kana is invalid',
                                                    "First name kana can't be blank", 'First name kana is invalid'
    end
    it 'ユーザー本名のフリガナは、全角（カタカナ）での入力が必須であること' do
      @user = FactoryBot.build(:user)
      @user.last_name_kana = 'ゼンカク'
      @user.first_name_kana = 'タロウ'
      @user.valid?
      expect(@user).to be_valid
    end
    it '生年月日が必須であること' do
      @user = FactoryBot.build(:user)
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end
