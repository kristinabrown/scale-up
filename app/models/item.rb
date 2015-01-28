class Item < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  has_many :category_items
  has_many :categories, through: :category_items
  has_many :order_items
  has_many :orders, through: :order_items
  belongs_to :image
  before_save :ensure_that_an_item_belongs_to_a_category
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true, allow_blank: false
  validates :unit_price, presence: true, allow_blank: false,
    numericality: { only_integer: true, greater_than: 0 }
  validate :has_category_items

  def has_category_items
    errors.add(:base, 'must add at least one category') if self.category_items.blank?
  end

  def ensure_that_an_item_belongs_to_a_category
    if self.categories.length < 1
      errors.add(:base, "A item needs a category")
    end
  end

  def dollar_amount
    number_to_currency(unit_price / 100.00)
  end

  def category_list
    categories.map { |cat| cat.name }.join(", ")
  end

  def status
    if active == true
      "Active"
    else
      "Inactive"
    end
  end

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
end
