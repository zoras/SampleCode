require 'test/unit'
require 'rest-client'
require 'json'
require 'yaml'

class FundsTransferTest < Test::Unit::TestCase
  def setup
    @strDate = Time.now.strftime("%Y-%m-%dT%H:%M:%S")
    @config = YAML.load_file('configuration.yml')
    @pushFundsRequest ='''{
    "systemsTraceAuditNumber": 350420,
    "retrievalReferenceNumber": "401010350420",
    "localTransactionDateTime": "'''+ @strDate + '''",
    "acquiringBin": 409999,
    "acquirerCountryCode": "101",
    "senderAccountNumber": "1234567890123456",
    "senderCountryCode": "USA",
    "transactionCurrencyCode": "USD",
    "senderName": "John Smith",
    "senderAddress": "44 Market St.",
    "senderCity": "San Francisco",
    "senderStateCode": "CA",
    "recipientName": "Adam Smith",
    "recipientPrimaryAccountNumber": "4957030420210454",
    "amount": "112.00",
    "businessApplicationId": "AA",
    "transactionIdentifier": 234234322342343,
    "merchantCategoryCode": 6012,
    "sourceOfFundsCode": "03",
    "cardAcceptor": {
      "name": "John Smith",
      "terminalId": "13655392",
      "idCode": "VMT200911026070",
      "address": {
        "state": "CA",
        "county": "081",
        "country": "USA",
        "zipCode": "94105"
      }
    },
    "feeProgramIndicator": "123"
    }'''
  end
  
  def test_pushFunds
    base_uri = 'visadirect/'
    resource_path = 'fundstransfer/v1/pushfundstransactions'
    url = "#{@config['visaUrl']}#{base_uri}#{resource_path}"
    user_id = @config['userId']
    password = @config['password']
    key_path = @config['key']
    cert_path = @config['cert']
    # Passing correlation id header (x-correlation-id) is optional while making API calls.  
    correlation_id = (0...12).map { (48 + rand(10)).chr }.join
    headers = {'content-type'=> 'application/json', 'accept' => 'application/json', 'x-correlation-id'=> "#{correlation_id}_SC"}
    puts " Push Funds Transactions test"
    puts url
    puts @pushFundsRequest
    begin
      response = RestClient::Request.execute(
      :method => :post,
      :url => url,
      :headers => headers,
      :payload => @pushFundsRequest,
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
      assert(false, "Push Funds Transactions test failed")
    end
  end
end