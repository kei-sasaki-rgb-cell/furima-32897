# テーブル設計

## usersテーブル

| Colmun            | Type   | Option                    |
| ----------------- | ------ | ------------------------- |
| nickname          | string | null: false               |
| email             | string | null: false, unique: true |
| password          | string | null: false               |
| last_name_kanji   | string | null: false               |
| first_name_kanji  | string | null: false               |
| last_name_hira    | string | null: false               |
| first_name_hira   | string | null: false               |
| last_name_kana    | string | null: false               |
| first_name_kana   | string | null: false               |
| birthday          | string | null: false               |

### Association

- has_many :items
- has_many :buyers

## itemsテーブル

| Colmun           | Type           | Option            |
| ---------------- | -------------- | ----------------- |
| image            | ActiveStorage  | null: false       |
| name             | string         | null: false       |
| description      | text           | null: false       |
| category_id      | integer        | null: false       |
| state_id         | integer        | null: false       |
| postage_id       | integer        | null: false       |
| prefecture_id    | integer        | null: false       |
| shipping_date_id | integer        | null: false       |
| price_id         | integer        | null: false       |
| user             | references     | foreign_key: true |

### Association

- belongs_to :user
- has_one :buyer

## buyersテーブル

| Colmun          | Type       | Option            |
| --------------- | -----------| ----------------- |
| user            | references | foreign_key: true |
| item            | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_many :ships

##  shipsテーブル

| Colmun          | Type       | Option            |
| --------------- | -----------| ----------------- |
| postcode        | string     | null: false       |
| prefecture_id   | integer    | null: false       |
| city            | string     | null: false       |
| block           | string     | null: false       |
| building        | string     |                   |
| phone_number    | string     | null: false       |
| user            | references | foreign_key: true |

### Association

- belongs_to :buyer