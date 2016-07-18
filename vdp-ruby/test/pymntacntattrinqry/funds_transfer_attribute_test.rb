require 'test/unit'
require 'rest-client'
require 'json'
require 'yaml'

class FundsTransferAttributesTest < Test::Unit::TestCase
  def setup
    @config = YAML.load_file('configuration.yml')
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
    url = "#{@config['visaUrl']}#{base_uri}#{resource_path}"
    user_id = @config['userId']
    password = @config['password']
    key_path = @config['key']
    cert_path = @config['cert']
    # Passing correlation id header (x-correlation-id) is optional while making API calls.  
    correlation_id = (0...12).map { (48 + rand(10)).chr }.join
    headers = {'content-type'=> 'application/json', 'accept'=> 'application/json', 'x-correlation-id'=> "#{correlation_id}_SC"}
    puts " Funds Transfer Inquiry test"
    puts url
    puts @fundsTransferInquiry
    begin
      response = RestClient::Request.execute(
      :method => :post,
      :url => url,
      :headers => headers,
      :payload => @fundsTransferInquiry,
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
      assert(false, "Funds Transfer Inquiry test failed")
    end
  end
end