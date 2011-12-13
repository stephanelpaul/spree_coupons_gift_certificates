module Spree::CouponsGiftCertificates
  class Config
    include Singleton
    include PreferenceAccess

    class << self
      def instance
        return nil unless ActiveRecord::Base.connection.tables.include?('configurations')
        CouponsGiftCertificatesConfiguration.find_or_create_by_name('Default product reviews and ratings configuration')
      end
    end
  end
end
