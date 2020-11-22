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
          expect(@user.errors.full_messages).to include("ニックネーム を入力してください。")
        end
        it 'nicknameが11文字以上だと登録できない' do
          @user.nickname = 'unicorngand'
          @user.valid?
          expect(@user.errors.full_messages).to include('ニックネーム は10文字以内で入力してください。')
        end
        it 'full_nameが空だと登録できない' do
          @user.full_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("名前 を入力してください。")
        end
        it 'full_nameが半角英数字だと登録できない' do
          @user.full_name = 'aaaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include('名前 を正しく入力してください。')
        end
        it 'full_nameが全角英数字だと登録できない' do
          @user.full_name = 'BBBB'
          @user.valid?
          expect(@user.errors.full_messages).to include('名前 を正しく入力してください。')
        end
        it 'full_name_kanaが空だと登録できない' do
          @user.full_name_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("名前(カタカナ) を入力してください。")
        end
        it 'full_name_kanaが平仮名だと登録できない' do
          @user.full_name_kana = 'たなか'
          @user.valid?
          expect(@user.errors.full_messages).to include('名前(カタカナ) を正しく入力してください。')
        end
        it 'full_name_kanaが半角英字だと登録できない' do
          @user.full_name_kana = 'tanaka'
          @user.valid?
          expect(@user.errors.full_messages).to include('名前(カタカナ) を正しく入力してください。')
        end
        it 'full_name_kanaが全角英字だと登録できない' do
          @user.full_name_kana = 'TANAKA'
          @user.valid?
          expect(@user.errors.full_messages).to include('名前(カタカナ) を正しく入力してください。')
        end
        it 'emailが空だと登録できない' do
          @user.email = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("メールアドレス を入力してください。")
        end
        it 'emailに@が無いと登録できない' do
          @user.email = 'aaagmail.com'
          @user.valid?
          expect(@user.errors.full_messages).to include('メールアドレス を正しく入力してください。')
        end
        it 'emailが重複していると登録できない' do
          @user.save
          another_user = FactoryBot.build(:user)
          another_user.email = @user.email
          another_user.valid?
          expect(another_user.errors.full_messages).to include('メールアドレス は既に登録されています。別のメールアドレスの登録をお願いします。')
        end
        it 'passwordが空だと登録できない' do
          @user.password = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("パスワード を入力してください。")
        end
        it 'passwordが6文字以下だと登録できない' do
          @user.password = 'qw123'
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワード は6文字以上で入力してください。')
        end
        it 'passwordが半角英数字のみだと登録できない' do
          @user.password = '123456'
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワード は半角英数字で6文字以上で入力してください。')
        end
        it 'passwordが半角英字のみだと登録できない' do
          @user.password = 'aaaaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワード は半角英数字で6文字以上で入力してください。')
        end
        it 'passwordが全角英数字だと登録できない' do
          @user.password = 'ASDFGH'
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワード は半角英数字で6文字以上で入力してください。')
        end
        it 'passwordが平仮名だと登録できない' do
          @user.password = 'わたしはぱす'
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワード は半角英数字で6文字以上で入力してください。')
        end
        it 'passwordがカタカナだと登録できない' do
          @user.password = 'ワタシハパス'
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワード は半角英数字で6文字以上で入力してください。')
        end
        it 'passwordが漢字だと登録できない' do
          @user.password = '私特殊暗号文'
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワード は半角英数字で6文字以上で入力してください。')
        end
        it 'password_confirmationがpasswordと一致しないと登録できない' do
          @user.password = '123asd'
          @user.password_confirmation = 'asdf12'
          @user.valid?
          expect(@user.errors.full_messages).to include("パスワード（確認用） を再度入力してください。")
        end
        it 'passwordが存在してもpassword_confirmationが空だと登録できない' do
          @user.password_confirmation = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("パスワード（確認用） を再度入力してください。")
        end
      end
    end
  end
end
