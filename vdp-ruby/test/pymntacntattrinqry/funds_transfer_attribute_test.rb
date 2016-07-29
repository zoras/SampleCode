require 'test/unit'
require 'rest-client'
require 'json'
require 'yaml'
require File.expand_path('../../../lib/abstract_visa_api_client', __FILE__)

class FundsTransferAttributesTest < Test::Unit::TestCase
  def setup
    @abstract_visa_api_client = AbstractVisaAPIClient.new
    @fundsTransferInquiry ='''{
    "acquirerCountryCode": "840",
    "acquiringBin": "408999",
    "primaryAccountNumber": "4957030420210512",
    "retrievalReferenceNumber": "330000550000",
    "systemsTraceAuditNumber": "451006"
  }'''
  end
  
  def test_fundsTransferInquiry
    base_uri = 'paai/'
    resource_path = 'fundstransferattinq/v1/cardattributes/fundstransferinquiry'
    response_code = @abstract_visa_api_client.doMutualAuthRequest("#{base_uri}#{resource_path}", "Funds Transfer Inquiry test", "post", @fundsTransferInquiry)
    assert_equal("200", response_code, "Funds Transfer Inquiry test failed")
  end
end