require "spree/coupons_gift_certificates/version"

class Engine < Rails::Engine
  config.autoload_paths += %W(#{config.root}/lib)

  def self.activate
    Order.send(:include, Spree::CouponsGiftCertificates::Order)
    Product.send(:include, Spree::CouponsGiftCertificates::Product)
    Coupon.send(:include, Spree::CouponsGiftCertificates::Coupon)
    CouponCredit.send(:include, Spree::CouponsGiftCertificates::CouponCredit)
    CheckoutsController.send(:include, Spree::CouponsGiftCertificates::CheckoutController)

    LineItem.class_eval do
      has_many :line_item_coupon
      has_many :coupons, :through => :line_item_coupon
    end

    Coupon.class_eval do
      has_one :line_item_coupon
      has_one :line_item, :through => :line_item_coupon
    end

    [ PaymentMethod::GiftCertificate ].each do |gw|
      begin
        gw.register
      rescue Exception => e
        $sterr.puts "Error registering gateway #{gw}: #{e}"
      end
    end
  end

end
