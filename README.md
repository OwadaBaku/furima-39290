# アプリケーション名
Furima
<br>
# アプリケーション概要
商品の出品を行い、出品した商品を他のユーザーが購入するというフリーマーケットのような仕様となっている。
<br>
# URL
https://furima-39290.onrender.com/
<br>
# テスト用アカウント
- Basic認証パスワード:2222
- Basic認証ID:admin
- メールアドレス:
- パスワード :
<br>
# 利用方法
1. トップページの上部からユーザー新規登録を行う。
2. 出品する場合、「出品する」から商品の出品ができ、購入する場合、商品を選択して必要な情報を記入することで購入することができる。
<br>
# アプリケーションを作成した背景
不用品を出品したい人、中古でも購入したい人をマッチングさせるため。
<br>
# 洗い出した要件
[要件を定義したシート](http:www.hogehoge)
<br>
# 実装した機能についての画像やGIFおよびその説明
～～画像やGIF、説明を記載～～
<br>
# 実装予定の機能
なし
<br>
# データベース設計
[![Image from Gyazo](https://i.gyazo.com/9e11e98b1a99ef829e0e0d82068031d4.png)](https://gyazo.com/9e11e98b1a99ef829e0e0d82068031d4)
<br>
# 画面遷移図
<br>

### usersテーブル
| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birthday           | date   | null: false               |

#### Association
	has_many :items
	has_many :orders

### items テーブル
| Column       	   		 | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| user           	  	 | references | null: false, foreign_key: true |
| item_name     	 	   | string     | null: false                    |
| item_description     | text       | null: false                    |
| category_id          | integer    | null: false                    |
| item_condition_id    | integer    | null: false                    |
| item_postage_id      | integer    | null: false                    |
| prefecture_id        | integer    | null: false                    |
| shipping_day_id      | integer    | null: false                    |
| price                | integer    | null: false                    |

#### Association
	belong_to :users
	has_one :order

### ordersテーブル
| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user          | references | null: false, foreign_key: true |
| item          | references | null: false, foreign_key: true |

#### Association
	belong_to :items
	has_one :user
	has_one :payment

### payments テーブル
| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| order_id      | references | null: false, foreign_key: true |
| postcode      | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| house_number  | string     | null: false                    |
| building_name | string     | null: false                    |
| phone_number  | string     | null: false                    |

#### Association
	belong_to :order

# 開発環境
- フロントエンド
- バックエンド
- テスト用アカウント
- テキストエディタ
- タスク管理
<br>
# ローカルでの動作方法
以下のコマンドを順に実行<br>
% git clone https://github.com/OwadaBaku/furima-39290.git<br>
% cd furima-39290<br>
% bundle install<br>
% yarn install
