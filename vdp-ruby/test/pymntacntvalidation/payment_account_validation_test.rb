require 'test/unit'
require 'rest-client'
require 'json'
require 'yaml'

class PaymentAccountValidationTest < Test::Unit::TestCase
  def setup
    @config = YAML.load_file('configuration.yml')
    @paymentAccountValidation ='''{
    "acquirerCountryCode": "840",
    "acquiringBin": "408999",
    "addressVerificationResults": {
      "postalCode": "T4B 3G5",
      "street": "801 Metro Center Blv"
    },
    "cardAcceptor": {
      "address": {
        "city": "San Francisco",
        "country": "USA",
        "county": "CA",
        "state": "CA",
        "zipCode": "94404"
      },
      "idCode": "111111",
      "name": "rohan",
      "terminalId": "123"
    },
    "cardCvv2Value": "672",
    "cardExpiryDate": "2018-06",
    "primaryAccountNumber": "4957030000313108",
    "retrievalReferenceNumber": "015221743720",
    "systemsTraceAuditNumber": "743720"
  }'''
  end
  
  def test_cardValidation
    base_uri = 'pav/'
    resource_path = 'v1/cardvalidation'
    url = "#{@config['visaUrl']}#{base_uri}#{resource_path}"
    user_id = @config['userId']
    password = @config['password']
    key_path = @config['key']
    cert_path = @config['cert']
    # Passing correlation id header (x-correlation-id) is optional while making API calls.  
    correlation_id = (0...12).map { (48 + rand(10)).chr }.join
    headers = {'content-type'=> 'application/json', 'accept'=> 'application/json', 'x-correlation-id'=> "#{correlation_id}_SC"}
    puts " Payment Account Validation test"
    puts url
    puts @paymentAccountValidation
    begin
      response = RestClient::Request.execute(
      :method => :post,
      :url => url,
      :headers => headers,
      :payload => @paymentAccountValidation,
      :user => user_id,
      :password => password,
      :ssl_client_key => OpenSSL::PKey::RSA.new(File.read(key_path)),
      :ssl_client_cert =>  OpenSSL::X509::Certificate.new(File.read(cert_path))
      )
      puts "Response Status : #{response.code.to_s}"
      puts "Response Headers : " 
      for header,value in response.headers
      puts "#{header.to_s} : #{value.to_s}"
      end
      puts "Response Body : " + JSON.pretty_generate(JSON.parse(response.body))
    rescue RestClient::ExceptionWithResponse => e
      puts "Response Status : #{e.response.code.to_s}"
      puts "Response Headers : " 
      for header,value in e.response.headers
      puts "#{header.to_s} : #{value.to_s}"
      end
      puts "Response Body : " + JSON.pretty_generate(JSON.parse(e.response.body))
      assert(false, "Payment Account Validation test failed")
    end
  end
end