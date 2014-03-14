require 'test_helper'

class RealexHppNotificationTest < Test::Unit::TestCase
  include ActiveMerchant::Billing::Integrations

  def setup
    @realex_hpp = RealexHpp::Notification.new(http_raw_data)
  end

  def test_accessors
    assert @realex_hpp.complete?
    assert_equal "", @realex_hpp.status
    assert_equal "", @realex_hpp.transaction_id
    assert_equal "", @realex_hpp.item_id
    assert_equal "", @realex_hpp.gross
    assert_equal "", @realex_hpp.currency
    assert_equal "", @realex_hpp.received_at
    assert @realex_hpp.test?
  end

  def test_compositions
    assert_equal Money.new(3166, 'USD'), @realex_hpp.amount
  end

  # Replace with real successful acknowledgement code
  def test_acknowledgement

  end

  def test_send_acknowledgement
  end

  def test_respond_to_acknowledge
    assert @realex_hpp.respond_to?(:acknowledge)
  end

  private
  def http_raw_data
    ""
  end
end
