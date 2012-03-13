$:.unshift File.expand_path('../../lib', __FILE__)
require "boundio"
require "minitest/autorun"
require "webmock/minitest"

class BoundioTest < MiniTest::Unit::TestCase
  def setup
    ENV["BOUNDIO_USER_SERIAL_ID"] = "user_serial_id"
    ENV["BOUNDIO_API_KEY"] = "api_key"
    ENV["BOUNDIO_USER_AUTHENTICATION_KEY"] = "user_authentication_key"
  end

end
