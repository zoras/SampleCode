require 'test/unit'
require 'rest-client'
require 'json'
require 'yaml'
require File.expand_path('../../../lib/abstract_visa_api_client', __FILE__)

class ProgramAdministrationTest < Test::Unit::TestCase
  def setup
    @abstract_visa_api_client = AbstractVisaAPIClient.new
  end
  
  def test_retrieveTransactionType
    base_uri = 'vctc/'
    resource_path = 'programadmin/v1/configuration/transactiontypecontrols'
    response_code = @abstract_visa_api_client.doMutualAuthRequest("#{base_uri}#{resource_path}", "Retrieve Transaction Type Control test", "get", '')
    assert_equal("200", response_code, "Retrieve Transaction Type Control test failed")
  end
end