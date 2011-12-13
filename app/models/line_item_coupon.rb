class LineItemCoupon < ActiveRecord::Base
  belongs_to :line_item
  belongs_to :coupon

  validates :line_item, :coupon, :presence => true
end
