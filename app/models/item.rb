class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :charge
  belongs_to :delivery_day
  belongs_to :prefecture

  with_options presence: true do
    with_options numericality: { other_than: 1, message: 'Select' } do
      validates :category_id
      validates :status_id
      validates :charge_id
      validates :delivery_day_id
      validates :prefecture_id
    end
    validates :product_name
    validates :description
    validates :image
    validates :price, numericality: { only_integer: true, message: 'Half-width number' }
    validates :price,
              numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                              message: 'Out of setting range' }
  end
  def was_attached?
    image.attached?
  end
end
