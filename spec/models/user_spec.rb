require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmation、last_name、first_name、last_name_kana、first_name_kana、birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
  end
  
    context '新規登録できないとき' do
      it 'nicknameがない場合は登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end

      it 'emailがない場合は登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end

      it 'emailが一意でない場合登録できない' do
        @existing_user = FactoryBot.create(:user, email: 'test@example.com')
        @user = FactoryBot.build(:user, email: 'test@example.com')
        @user.valid?
        expect(@user.errors[:email]).to include 'has already been taken'
      end

      it 'emailに@を含んでいない場合登録できない' do
        @user.email = 'testexample.com'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Email is invalid'
      end

      it 'passwordがない場合登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end

      it 'passwordが6文字以上でない場合登録できない' do
        @user.password = 'pass'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
      end

      it 'passwordが半角英数字混合でなく数字のみの場合登録できない' do
        @user.password = '123456' #数字のみの場合
        @user.valid?
        unless @user.password =~ /^(?=.*[a-zA-Z])(?=.*\d).*$/
          expect(@user.errors.full_messages).to include 'Password is invalid. Include both letters and numbers'
        end
      end

      it 'passwordが半角英数字混合でなく英字のみの場合登録できない' do
        @user.password = 'password' #英字のみの場合
        @user.valid?
        unless @user.password =~ /^(?=.*[a-zA-Z])(?=.*\d).*$/
          expect(@user.errors.full_messages).to include 'Password is invalid. Include both letters and numbers'
        end
      end

      it 'passwordとpassword_confirmationの値が一致しない場合登録できない' do
        @user.password_confirmation = 'invalid_password'
        @user.valid?
        expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
      end

        it 'last_nameがない場合登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name can't be blank"
      end

      it 'last_nameが全角（漢字・ひらがな・カタカナ）でない場合登録できない' do
        @user.last_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters.')
      end

        it 'first_nameがない場合登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank"
      end

      it 'first_nameが全角（漢字・ひらがな・カタカナ）でない場合登録できない' do
        @user.first_name = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters.')
      end

      it 'last_name_kanaがない場合登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana can't be blank"
      end

      it 'last_name_kanaがカタカナでない場合登録できない' do
        @user.last_name_kana = '山田'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters.')
      end

      it 'first_name_kanaがない場合登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name kana can't be blank"
      end

      it 'first_name_kanaが全角（漢字・ひらがな・カタカナ）でない場合登録できない' do
        @user.first_name_kana = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters.')
      end

      it 'birthdayがない場合登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Birthday can't be blank"
      end
    end
  end

  # describe "ユーザー新規登録" do
  #   it "適切な情報を入力して会員登録ボタンを押すとユーザーの新規登録が可能であること" do
  #     user = FactoryBot.build(:user)
  #     expect(user.save).to be_truthy
  #   end

  #   it "重複したエラーメッセージが表示されないこと" do
  #     user = FactoryBot.build(:user, email: nil, nickname: nil)  # 無効なデータ（emailとnicknameがnil）
  #     user.validate  # バリデーションを実行

  #     expect(user.errors.count).to eq(2)  # エラーメッセージの数が2であることを確認
  #     expect(user.errors.full_messages.uniq.count).to eq(2)  # 重複したエラーメッセージがないことを確認
  #   end

  #   context "正しいデータを入力した場合" do
  #     it "登録が成功すること" do
  #       user = FactoryBot.build(:user)
  #       expect(user.save).to be_truthy
  #     end
  #   end

  #   context "無効なデータを入力した場合" do
  #     it "登録が失敗すること" do
  #       user = FactoryBot.build(:user, email: nil)  # 無効なデータ（emailがnil）
  #       expect(user.save).to be_falsey
  #     end
  #   end
  # end

  #   describe "ログイン" do
  #     it "適切な情報を入力してログインボタンを押すとユーザーがログインできること" do
  #       user = FactoryBot.create(:user, email: 'test@example.com', password: 'password123')

  #       post "/login", params: { email: 'test@example.com', password: 'password123' }

  #       expect(response).to redirect_to(root_path)  # ログイン後にリダイレクトされることを確認
  #       expect(session[:user_id]).to eq(user.id)  # セッションにログインユーザーのIDが保存されることを確認
  #     end
  #   end

  #   end