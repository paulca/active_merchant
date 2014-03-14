require 'test_helper'

class RealexHppHelperTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations
  
  def setup
    @helper = RealexHpp::Helper.new('order-500','paulcampbelltest', :amount => 5000, :currency => 'USD')
  end
 
  def test_basic_helper_fields
    assert_field 'MERCHANT_ID', 'paulcampbelltest'

    assert_field 'AMOUNT', '5000'
    assert_field 'ORDER_ID', 'order-500'
  end

  def test_billing_address_mapping
    @helper.billing_address :address1 => '1 My Street',
                            :address2 => '',
                            :city => 'Leeds',
                            :state => 'Yorkshire',
                            :zip => 'LS2 7EE',
                            :country  => 'CA'
   
    assert_field 'BILLING_CODE', 'LS2 7EE'
    assert_field 'BILLING_CO', 'CA'
  end

  def test_shipping_address_mapping
    @helper.shipping_address :address1 => '1 My Street',
                            :address2 => '',
                            :city => 'Leeds',
                            :state => 'Yorkshire',
                            :zip => 'LS2 7EE',
                            :country  => 'CA'
    assert_field 'SHIPPING_CODE', 'LS2 7EE'
    assert_field 'SHIPPING_CO', 'CA'
  end
  
  def test_unknown_address_mapping
    @helper.billing_address :farm => 'CA'
    assert_equal 3, @helper.fields.size
  end

  def test_unknown_mapping
    assert_nothing_raised do
      @helper.company_address :address => '500 Dwemthy Fox Road'
    end
  end
  
  def test_setting_invalid_address_field
    fields = @helper.fields.dup
    @helper.billing_address :street => 'My Street'
    assert_equal fields, @helper.fields
  end
end
