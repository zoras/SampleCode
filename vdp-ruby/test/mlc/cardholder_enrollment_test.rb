require 'test/unit'
require 'rest-client'
require 'json'
require 'yaml'
require File.expand_path('../../../lib/abstract_visa_api_client', __FILE__)

class CardholderEnrollmentTest < Test::Unit::TestCase
  def setup
    @abstract_visa_api_client = AbstractVisaAPIClient.new
    @config = YAML.load_file('configuration.yml')
    @enrollementData ='''{
    "enrollmentMessageType": "enroll",
    "enrollmentRequest": {
      "cardholderMobileNumber": "0016504323000",
      "clientMessageID": "'''+ @config['mlcClientMessageID'] + '''",
      "deviceId": "'''+ @config['mlcDeviceId'] + '''",
      "issuerId": "'''+ @config['mlcIssuerId'] + '''",
      "primaryAccountNumber": "'''+ @config['mlcPrimaryAccountNumber'] + '''"
    }
  }'''
  end
  
  def test_cardEnrollment
    base_uri = 'mlc/'
    resource_path = 'enrollment/v1/enrollments'
    response_code = @abstract_visa_api_client.doMutualAuthRequest("#{base_uri}#{resource_path}", "Cardholder Enrollment test", "post", @enrollementData)
    assert_equal("200", response_code, "Cardholder Enrollment test failed")
  end
end