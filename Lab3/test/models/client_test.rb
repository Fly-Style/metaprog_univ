require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  testClient = Client.new
  testClient.balance = 1000
  testClient.is_book = false

  assert_not testClient.save
end
