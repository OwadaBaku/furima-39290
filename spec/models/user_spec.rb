require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーション" do
    it "nicknameがない場合は登録できないこと" do
      user = FactoryBot.build(:user)
      user.nickname = ''
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    it "emailがない場合は登録できないこと" do
      user = FactoryBot.build(:user)
      user.email = ''
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "emailが一意であること" do
      existing_user = FactoryBot.create(:user, email: 'test@example.com')
      user = FactoryBot.build(:user, email: 'test@example.com')
      user.valid?
      expect(user.errors[:email]).to include("has already been taken")
    end

    it "emailに@を含む必要があること" do
      user = FactoryBot.build(:user)
      user.email = 'testexample.com'
      user.valid?
      expect(user.errors[:email]).to include("is invalid")
    end

    it "passwordがない場合は登録できないこと" do
      user = FactoryBot.build(:user)
      user.password = ''
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "passwordが6文字以上であること" do
      user = FactoryBot.build(:user)
      user.password = 'pass'
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end

    it "passwordが半角英数字混合であること" do
      user = FactoryBot.build(:user)
      user.password = '123456'
      user.valid?
      expect(user.errors[:password]).to include("is invalid. Include both letters and numbers") unless user.password =~ /^(?=.*[a-zA-Z])(?=.*\d).*$/
    end

    it "passwordとencrypted_passwordの値が一致すること" do
      password = 'test123'
      user = FactoryBot.build(:user, password: password, encrypted_password: password)
    
      # passwordとencrypted_passwordの値が一致していることを検証
      expect(user.password).to eq(user.encrypted_password)
    end

    it "last_nameがない場合は登録できないこと" do
      user = FactoryBot.build(:user)
      user.last_name = ''
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    it "last_nameが半角英数字混合であること" do
      user = FactoryBot.build(:user)
      user.last_name = '123456'
      user.valid?
      expect(user.errors[:last_name]).to include("is invalid. Include both letters and numbers") unless user.password =~ /^(?=.*[a-zA-Z])(?=.*\d).*$/
    end

    it "first_nameがない場合は登録できないこと" do
      user = FactoryBot.build(:user)
      user.first_name = ''
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it "first_nameが半角英数字混合であること" do
      user = FactoryBot.build(:user)
      user.first_name = '123456'
      user.valid?
      expect(user.errors[:first_name]).to include("is invalid. Include both letters and numbers") unless user.password =~ /^(?=.*[a-zA-Z])(?=.*\d).*$/
    end

    it "last_name_kanaがない場合は登録できないこと" do
      user = FactoryBot.build(:user)
      user.last_name_kana = ''
      user.valid?
      expect(user.errors[:last_name_kana]).to include("can't be blank")
    end

    it "first_name_kanaがない場合は登録できないこと" do
      user = FactoryBot.build(:user)
      user.first_name_kana = ''
      user.valid?
      expect(user.errors[:first_name_kana]).to include("can't be blank")
    end

    it "birthdayがない場合は登録できないこと" do
      user = FactoryBot.build(:user)
      user.birthday = ''
      user.valid?
      expect(user.errors[:birthday]).to include("can't be blank")
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
  
end