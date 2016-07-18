require 'test/unit'
require 'rest-client'
require 'json'
require 'yaml'

class GeneralAttributesInquiryTest < Test::Unit::TestCase
  def setup
    @config = YAML.load_file('configuration.yml')
    @generalAttributeInquiry ='''{
      "primaryAccountNumber": "4465390000029077"
    }'''
  end
  
  def test_fundsTransferInquiry
    base_uri = 'paai/'
    resource_path = 'generalattinq/v1/cardattributes/generalinquiry'
    url = "#{@config['visaUrl']}#{base_uri}#{resource_path}"
    user_id = @config['userId']
    password = @config['password']
    key_path = @config['key']
    cert_path = @config['cert']
    # Passing correlation id header (x-correlation-id) is optional while making API calls.  
    correlation_id = (0...12).map { (48 + rand(10)).chr }.join
    headers = {'content-type'=> 'application/json', 'accept'=> 'application/json', 'x-correlation-id'=> "#{correlation_id}_SC"}
    puts " General Attributes Inquiry test"
    puts url
    puts @generalAttributeInquiry
    begin
      response = RestClient::Request.execute(
      :method => :post,
      :url => url,
      :headers => headers,
      :payload => @generalAttributeInquiry,
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
      assert(false, "General Attributes Inquiry test failed")
    end
  end
end