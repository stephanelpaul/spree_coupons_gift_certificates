require 'active_support/concern'

module Spree::CouponsGiftCertificates::CouponCredit
  extend ActiveSupport::Concern

  included do
    alias :spree_calculate_coupon_credti :calculate_coupon_credit
  end

  def calculate_coupon_credit
    return 0 if order.line_items.empty?
    amount = adjustment_source.compute(order.line_items).abs
    order_total = adjustment_source.include?('giftcert-') ? order.item_total + order.charges.total : order.item_total
    amount = order_total if amount > order_total
    -1 * amount
  end
end
