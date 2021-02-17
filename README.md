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

| Colmun          | Type           | Option            |
| --------------- | -------------- | ----------------- |
| item_image      | ActiveStorage  | null: false       |
| item_name       | string         | null: false       |
| description     | text           | null: false       |
| category        |                | null: false       |
| state           |                | null: false       |
| postage         |                | null: false       |
| shipping_date   |                | null: false       |
| price           | integer        | null: false       |
| user            | references     | foreign_key: true |

### Association

- belongs_to :user
- has_one :buyer

## buyersテーブル

| Colmun          | Type       | Option            |
| --------------- | -----------| ----------------- |
| postcode        | integer    | null: false       |
| prefecture_id   |            | null: false       |
| city            | string     | null: false       |
| block           | string     | null: false       |
| building        | string     |                   |
| phone_number    | string     | null: false       |
| user            | references | foreign_key: true |

### Association

- belongs_to :item
- has_one :saler

## salersテーブル

| Colmun          | Type       | Option            |
| --------------- | -----------| ----------------- |
| postcode        | integer    | null: false       |
| prefecture_id   |            | null: false       |
| city            | string     | null: false       |
| block           | string     | null: false       |
| building        | string     |                   |
| phone_number    | string     | null: false       |
| user            | references | foreign_key: true |

### Association

- belongs_to :buyer