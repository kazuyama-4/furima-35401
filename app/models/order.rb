class Order
  include ActiveModel::Model
  attr_accessor :token, :user_id, :item_id, :postal, :prefecture_id, :city, :house_number, :building, :call_number,
                :purchase_id

  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  with_options presence: true do
    validates :token
    validates :user_id
    validates :item_id
    validates :postal, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows(e.g. 123-4567)' }
    validates :city
    validates :house_number
    with_options format: { with: /\A\d{11}\z/, message: 'is too short' } do
      validates :call_number, numericality: { only_integer: true, message: 'is invalid. Input only number' },
                              length: { maximum: 11, message: 'is too long' }
    end
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(postal: postal, prefecture_id: prefecture_id, city: city, house_number: house_number,
                   call_number: call_number, building: building, purchase_id: purchase_id)
  end
end
