require 'digest/sha1'
module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module RealexHpp
        class Helper < ActiveMerchant::Billing::Integrations::Helper

          mapping :account, 'MERCHANT_ID'
          mapping :credential2, 'SHARED_SECRET'
          mapping :credential3, 'ACCOUNT'

          mapping :amount, 'AMOUNT'
          mapping :currency, 'CURRENCY'
        
          mapping :order, 'ORDER_ID'

          mapping :customer, :first_name => '',
                             :last_name  => '',
                             :email      => '',
                             :phone      => ''

          mapping :billing_address, :city     => '',
                                    :address1 => '',
                                    :address2 => '',
                                    :state    => '',
                                    :zip      => 'BILLING_CODE',
                                    :country  => 'BILLING_CO'
          
          mapping :shipping_address, :city     => '',
                                    :address1 => '',
                                    :address2 => '',
                                    :state    => '',
                                    :zip      => 'SHIPPING_CODE',
                                    :country  => 'SHIPPING_CO'

          mapping :notify_url, ''
          mapping :return_url, ''
          mapping :cancel_return_url, ''
          mapping :description, ''
          mapping :tax, ''
          mapping :shipping, ''

          def initialize(order, account, options = {})
            super
            add_field('SHA1HASH', request_hash)
            add_field('TIMESTAMP', timestamp)
            add_field('AUTO_SETTLE_FLAG', 1)
          end

          def form_fields
            @fields.reject { |k| k == 'SHARED_SECRET' }
          end

          # eg. "20130814122239
          def timestamp
            @timestamp ||= Time.now.strftime("%Y%m%d%I%M%S")
          end

          def hash_first_pass_parts
            [
              timestamp,
              @fields['MERCHANT_ID'],
              @fields['ORDER_ID'],
              @fields['AMOUNT'],
              @fields['CURRENCY']
            ]
          end

          # eg. TIMESTAMP.MERCHANT_ID.ORDER_ID.AMOUNT.CURRENCY
          def hash_first_pass
            Digest::SHA1.hexdigest(hash_first_pass_parts.join('.'))
          end

          def request_hash_parts
            [hash_first_pass, @fields["SHARED_SECRET"]]
          end

          def request_hash
            Digest::SHA1.hexdigest(request_hash_parts.join('.'))
          end
        end
      end
    end
  end
end
