require 'test_helper'

class RealexHppModuleTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations
  
  def test_notification_method
    assert_instance_of RealexHpp::Notification, RealexHpp.notification('name=cody', {})
  end

  def test_test_mode
    ActiveMerchant::Billing::Base.integration_mode = :test
    assert_equal 'https://hpp.sandbox.realexpayments.com/pay', RealexHpp.service_url
  end

  def test_production_mode
    ActiveMerchant::Billing::Base.integration_mode = :production
    assert_equal 'https://hpp.realexpayments.com/pay', RealexHpp.service_url
  end

  def test_invalid_mode
    ActiveMerchant::Billing::Base.integration_mode = :zoomin
    assert_raise(StandardError){ RealexHpp.service_url }
  end
  
  def test_return_method
    assert_instance_of RealexHpp::Return, RealexHpp.return('name=cody', {})
  end
end 