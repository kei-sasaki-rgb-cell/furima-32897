class FormObj
  include ActiveModel::Model
  attr_accessor :user, :item, :postcode, :prefecture, :city, :block, :building, :phone_number, :buyer

  # ここにバリデーションの処理を書く
  with_options presence: true do
    validates :postcode, format: { with: /\A\d{3}[-]\d{4}\z/ }
    validates :prefecture
    validates :city
    validates :block
    validates :phone_number, format: { with: /\A\d{11}\z/ }
  end

  def save
    # 各テーブルにデータを保存する処理を書く
    buyer = Buyer.create(user: user, item: item)
    Ship.create(postcode: postcode, prefecture: prefecture, city: city, block: block, building: building, phone_number: phone_number, buyer_id: buyer.id)
  end
end