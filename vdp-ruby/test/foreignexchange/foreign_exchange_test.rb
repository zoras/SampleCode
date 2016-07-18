require 'test/unit'
require 'rest-client'
require 'json'
require 'yaml'

class ForeignExchangeTest < Test::Unit::TestCase
  def setup
    @config = YAML.load_file('configuration.yml')
    @foreignExchangeRequest ='''{
    "acquirerCountryCode": "840",
    "acquiringBin": "408999",
    "cardAcceptor": {
      "address": {
        "city": "San Francisco",
        "country": "USA",
        "county": "San Mateo",
        "state": "CA",
        "zipCode": "94404"
      },
      "idCode": "ABCD1234ABCD123",
      "name": "ABCD",
      "terminalId": "ABCD1234"
    },
    "destinationCurrencyCode": "826",
    "markUpRate": "1",
    "retrievalReferenceNumber": "201010101031",
    "sourceAmount": "100.00",
    "sourceCurrencyCode": "840",
    "systemsTraceAuditNumber": "350421"
  }'''
  end
  
  def test_foreignExchange
    base_uri = 'forexrates/'
    resource_path = 'v1/foreignexchangerates'
    url = "#{@config['visaUrl']}#{base_uri}#{resource_path}"
    user_id = @config['userId']
    password = @config['password']
    key_path = @config['key']
    cert_path = @config['cert']
    # Passing correlation id header (x-correlation-id) is optional while making API calls.  
    correlation_id = (0...12).map { (48 + rand(10)).chr }.join
    headers = {'content-type'=> 'application/json', 'accept'=> 'application/json', 'x-correlation-id'=> "#{correlation_id}_SC"}
    puts " Foreign Exchange test"
    puts url
    puts @foreignExchangeRequest
    begin
      response = RestClient::Request.execute(
      :method => :post,
      :url => url,
      :headers => headers,
      :payload => @foreignExchangeRequest,
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
      assert(false, "Foreign Exchange test failed")
    end
  end
end