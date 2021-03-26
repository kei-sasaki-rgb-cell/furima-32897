class Ship < ApplicationRecord
  belongs_to :buyer

  # ここにバリデーションの処理を書く
  with_options presence: true do
    validates :postcode, format: { with: /\A\d{3}-\d{4}\z/ }
    validates :prefecture_id
    validates :city
    validates :block
    validates :phone_number, format: { with: /\A\d{11}\z/ }
  end

  validates :prefecture_id, numericality: { other_than: 1 }
end
