require 'active_support/concern'

module Spree::CouponsGiftCertificate::CheckoutsController
  extend ActiveSupport::Concern

  included do
    alias :spree_load_available_payment_methods :load_available_payment_methods
  end

  def load_available_payment_methods
    @payment_methods = PaymentMethod.available(:front_end)

    if object.order.total > 0
      @payment_methods = @payment_methods.select { |pm| pm.name != 'Gift Certificate'}

      if @checkout.payment && @checkout.payment.payment_method && @payment_methods.include?(@checkout.payment.payment_method)
        @payment_method = @checkout.payment.payment_method
      else
        @payment_method = @payment_methods.first
      end
    else
      @payment_methods = @payment_methods.select{ |pm| pm.name == 'Gift Certificate'}
      @payment_metbod = @payment_methods.first
    end

  end
end
