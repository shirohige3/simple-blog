require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context 'ユーザー新規登録がうまく行く時' do
      it 'nickname, full_name, full_name_kana, password, password_confirmationがあれば登録できる' do
        expect(@user).to be_valid
      end
      context 'ユーザー新規登録がうまくいかない時' do
        it 'nicknameが空だと登録できない' do
          @user.nickname = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Nickname can't be blank")
        end
        it 'nicknameが11文字以上だと登録できない' do
          @user.nickname = 'unicorngand'
          @user.valid?
          expect(@user.errors.full_messages).to include('Nickname is too long (maximum is 10 characters)')
        end
        it 'full_nameが空だと登録できない' do
          @user.full_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Full name can't be blank")
        end
        it 'full_nameが半角英数字だと登録できない' do
          @user.full_name = 'aaaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include('Full name is invalid')
        end
        it 'full_nameが全角英数字だと登録できない' do
          @user.full_name = 'BBBB'
          @user.valid?
          expect(@user.errors.full_messages).to include('Full name is invalid')
        end
        it 'full_name_kanaが空だと登録できない' do
          @user.full_name_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Full name kana can't be blank")
        end
        it 'full_name_kanaが平仮名だと登録できない' do
          @user.full_name_kana = 'たなか'
          @user.valid?
          expect(@user.errors.full_messages).to include('Full name kana is invalid')
        end
        it 'full_name_kanaが半角英字だと登録できない' do
          @user.full_name_kana = 'tanaka'
          @user.valid?
          expect(@user.errors.full_messages).to include('Full name kana is invalid')
        end
        it 'full_name_kanaが全角英字だと登録できない' do
          @user.full_name_kana = 'TANAKA'
          @user.valid?
          expect(@user.errors.full_messages).to include('Full name kana is invalid')
        end
        it 'emailが空だと登録できない' do
          @user.email = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end
        it 'emailに@が無いと登録できない' do
          @user.email = 'aaagmail.com'
          @user.valid?
          expect(@user.errors.full_messages).to include('Email is invalid')
        end
        it 'emailが重複していると登録できない' do
          @user.save
          another_user = FactoryBot.build(:user)
          another_user.email = @user.email
          another_user.valid?
          expect(another_user.errors.full_messages).to include('Email has already been taken')
        end
        it 'passwordが空だと登録できない' do
          @user.password = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank")
        end
        it 'passwordが6文字以下だと登録できない' do
          @user.password = 'qw123'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
        end
        it 'passwordが半角英数字のみだと登録できない' do
          @user.password = '123456'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is invalid')
        end
        it 'passwordが半角英字のみだと登録できない' do
          @user.password = 'aaaaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is invalid')
        end
        it 'passwordが全角英数字だと登録できない' do
          @user.password = 'ASDFGH'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is invalid')
        end
        it 'passwordが平仮名だと登録できない' do
          @user.password = 'わたしはぱす'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is invalid')
        end
        it 'passwordがカタカナだと登録できない' do
          @user.password = 'ワタシハパス'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is invalid')
        end
        it 'passwordが漢字だと登録できない' do
          @user.password = '私特殊暗号文'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is invalid')
        end
        it 'password_confirmationがpasswordと一致しないと登録できない' do
          @user.password = '123asd'
          @user.password_confirmation = 'asdf12'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end
        it 'passwordが存在してもpassword_confirmationが空だと登録できない' do
          @user.password_confirmation = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end
      end
    end
  end
end
