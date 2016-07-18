require 'test/unit'
require 'rest-client'
require 'json'
require 'yaml'

class MVisaTest < Test::Unit::TestCase
  def setup
    @config = YAML.load_file('configuration.yml')
    @strDate = Time.now.utc.strftime("%Y-%m-%dT%H:%M:%S")
    @mVisaTransactionRequest ='''{
    "acquirerCountryCode": "643",
    "acquiringBin": "400171",
    "amount": "124.05",
    "businessApplicationId": "CI",
    "cardAcceptor": {
      "address": {
        "city": "Bangalore",
        "country": "IND"
      },
      "idCode": "ID-Code123",
      "name": "Card Accpector ABC"
    },
    "localTransactionDateTime": "''' + @strDate + '''",
    "merchantCategoryCode": "4829",
    "recipientPrimaryAccountNumber": "4123640062698797",
    "retrievalReferenceNumber": "430000367618",
    "senderAccountNumber": "4541237895236",
    "senderName": "Mohammed Qasim",
    "senderReference": "1234",
    "systemsTraceAuditNumber": "313042",
    "transactionCurrencyCode": "USD",
    "transactionIdentifier": "381228649430015"
  }'''
  end
  
  def test_mVisaTransacation
    base_uri = 'visadirect/'
    resource_path = 'mvisa/v1/cashinpushpayments'
    url = "#{@config['visaUrl']}#{base_uri}#{resource_path}"
    user_id = @config['userId']
    password = @config['password']
    key_path = @config['key']
    cert_path = @config['cert']
    # Passing correlation id header (x-correlation-id) is optional while making API calls.  
    correlation_id = (0...12).map { (48 + rand(10)).chr }.join
    headers = {'content-type'=> 'application/json', 'accept' => 'application/json', 'x-correlation-id'=> "#{correlation_id}_SC"}
    puts " M-Visa Transacation test"
    puts url
    puts @mVisaTransactionRequest
    begin
      response = RestClient::Request.execute(
      :method => :post,
      :url => url,
      :headers => headers,
      :payload => @mVisaTransactionRequest,
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
      assert(false, "M-Visa Transacation test failed")
    end
  end
end