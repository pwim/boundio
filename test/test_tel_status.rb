# encoding: UTF-8
require "test_helper"

class TestTelStatus < BoundioTest
  def test_find_with_id
    stub_request(:get, "https://boundio.jp/api/vd1/user_serial_id/tel_status?auth=user_authentication_key&key=api_key&tel_id=5").to_return(:body => {:success => "true", :result => [:_id => 5]}.to_json)
    call_status = Boundio::TelStatus.find(5)
    assert_equal 5, call_status.id
  end

  def test_status
    assert Boundio::TelStatus.new(:status => "架電待機").processing?
    assert !Boundio::TelStatus.new(:status => "不在").processing?
  end
end
