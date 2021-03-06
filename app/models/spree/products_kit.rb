class Spree::ProductsKit < ActiveRecord::Base
  has_many :products_kit_items
  alias_method :items, :products_kit_items

  attr_accessible :enabled
  accepts_nested_attributes_for :products_kit_items

  scope :enabled, where(enabled: true)

  def primary_product
  	products_kit_items.where(is_primary: true).first.try(:variant)
  end

  def secondary_products
  	products_kit_items.where(is_primary: false).collect(&:variant)
  end

  def total_discount
    products_kit_items.collect(&:discount).inject(&:+)
  end
end
