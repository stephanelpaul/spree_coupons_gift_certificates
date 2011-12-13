require 'active_support/concern'

module Spree::CouponsGiftCertificates::Coupon
  extend ActiveSupport::Concert

  include do 
    alias :spree_eligible? :eligible?
  end

  def eligible?(order)
    return false if expires_at && Time.now > expires_at
    return false if usage_limit && coupon_credits.with_order_count  >= usage_limit
    return false if starts_at && Time.now < starts_at
    return false if code =~ /^giftcert-/ && calculator.preferred_amount == 0
    true
  end
end
