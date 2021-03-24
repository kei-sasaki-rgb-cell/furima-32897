class FormObj
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postcode, :prefecture_id, :city, :block, :building, :phone_number, :token  #コントローラーから受け取る側

  # ここにバリデーションの処理を書く
  with_options presence: true do
    validates :postcode, format: { with: /\A\d{3}[-]\d{4}\z/ }
    validates :prefecture_id
    validates :city
    validates :block
    validates :phone_number, format: { with: /\A\d{11}\z/ }
    validates :token
  end

  validates :prefecture_id, numericality: { other_than: 1 }

  def save
    # 各テーブルにデータを保存する処理を書く
    buyer = Buyer.create(user_id: user_id, item_id: item_id)
    Ship.create(postcode: postcode, prefecture_id: prefecture_id, city: city, block: block, building: building, phone_number: phone_number, buyer_id: buyer.id)
  end
end