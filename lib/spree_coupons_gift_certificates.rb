require 'spree/coupons_gift_certificates/version'

class Engine < Rails::Engine
  def self.activate
    Order.send(:include, Spree::CouponsGiftCertificates::Order)
    Product.send(:include, Spree::CouponsGiftCertificates::Product)
    Coupon.send(:include, Spree::CouponsGiftCertificates::Coupon)
    CouponCredit.send(:include, Spree::CouponsGiftCertificates::CouponCredit)


    LineItem.class_eval do 

    end

    Coupon.class_eval do 

    end


    [PaymentMethod::GiftCertificate].each do |gw|
      begin
        gw.register
      rescue Exception => e
        $stderr.puts "Error registering gateway #{gw}: #{e}"
      end
    end
  end
end
