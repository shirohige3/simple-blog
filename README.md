# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

#テーブル設計

##users テーブル
| Column           | Type       | Options          |
| ---------------- | -----------| ---------------- |
| nickname         | string     | null: false      |
| email            | string     | null: false      |
| password         | string     | null: false      |
| introduction     | text       |                  |
| full_name        | string     | null: false      |
| full_name_kana   | string     | null: false      |
| birth_date       | date       |                  |
### Association
- has_many         :blogs
- has_many         :comments
- has_one_attached :image

##blogs テーブル
| Column           | Type       | Options                        |
| ---------------- | -----------| ------------------------------ |
| title            | string     | null: false                    |
| text             | text       | null: false                    |
| status           | integer    | null: false,  default: 0       |
| user             | references | null: false, foreign_key: true |
### Association
- belongs_to       :user
- has_many         :comments
- has_many         :blog_tags
- has_many         :tags through: :blog_tags
- has_one_attached :image

##comments テーブル
| Column           | Type           | Options                        |
| ---------------- | ---------------| ------------------------------ |
| user             | references     | null: false, foreign_key: true |
| blog             | references     | null: false, foreign_key: true |
| text             | text           | null: false                    |

### Association
- belongs_to  :user
- belongs_to  :blog

##tags テーブル
| Column           | Type       | Options                       |
| ---------------- | -----------| ----------------------------- |
| name             | string     | null: false, uniqueness: true |

### Association
- has_many  :blog_tags
- has_many  :blogs through: blog_tags

##blog_tags テーブル
| Column           | Type       | Options                        |
| ---------------- | -----------| ------------------------------ |
| blog             | references | null: false, foreign_key: true |
| tag              | references | null: false, foreign_key: true |
### Association
- belongs_to :blog
- belongs_to :tag

#アプリケーション名
simple-blog

#アプリケーション概要
*ブログ記事投稿サイトです。
*ユーザーの登録・登録内容の変更が若干できます。
*ブログ記事を投稿・編集・削除・またブログ記事に対してコメントができます。

#URL
*https://simple-blog29760.herokuapp.com/ 
*https://github.com/shirohige3/simple-blog

#テスト用アカウント
##test-user1
*email:    tanaka12@gmail.com
*password: tanaka12

##test-user2
*email:   suzuki12@gmail.com
*pasword: suzuki12

#利用方法
##header
*記事検索はタイトルを入れることで記事を検索できます。
*『新規登録』はユーザーを新しく登録できます。『ログイン』は既に登録してあるユーザーでログインできます。
*ユーザーがログインしている状態だと『ユーザー名』はマイページへ遷移できます。『ログアウト』はログインしているユーザーをログアウトさせます。
#side-bar
*記事を書くから記事の投稿ができます。
*
*
*
*
*
*
*



#目指した課題解決

#洗い出した要件

#実装した機能についてのGIFと説明

#実装予定の機能

#ローカルでの動作方法


