class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_one :buyer

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :state
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :shipping_date

  # 空の投稿を保存できないようにする
  with_options presence: true do
    validates :image
    validates :name
    validates :description

    validates :category_id
    validates :state_id
    validates :postage_id
    validates :prefecture_id
    validates :shipping_date_id

    VALID_PRICE_REGEX = /\A[0-9]+\z/
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                      format: { with: VALID_PRICE_REGEX }
  end

  # 選択が「--」の時は保存できないようにする
  validates :category_id, :state_id, :postage_id, :prefecture_id, :shipping_date_id, numericality: { other_than: 1 }
end
