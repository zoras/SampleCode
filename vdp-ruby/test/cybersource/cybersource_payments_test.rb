require 'test/unit'
require 'rest-client'
require 'json'
require 'yaml'
require File.expand_path('../../../lib/x_pay_utils', __FILE__)

class CybersourcePaymentsTest < Test::Unit::TestCase
  
  def setup
    @config = YAML.load_file('configuration.yml')
    @x_pay_util = XPayUtils.new
    @paymentAuthorizationRequest='''{
      "amount": "0",
      "currency": "USD",
      "payment": {
        "cardNumber": "4111111111111111",
        "cardExpirationMonth": "10",
        "cardExpirationYear": "2016"
       }
    }'''
  end
  
  def test_authorize_payments
    base_uri = 'cybersource/'
    resource_path = 'payments/v1/authorizations'
    api_key = @config['apiKey']
    url = "#{@config['visaUrl']}#{base_uri}#{resource_path}?apikey=#{api_key}"
    shared_secret = @config['sharedSecret']
    query_string = "apikey=#{api_key}"
    xpay_token = @x_pay_util.get_xpay_token(resource_path,query_string,@paymentAuthorizationRequest)
    puts " Payment Authorization Request test"
    puts url
    puts @paymentAuthorizationRequest
    # Passing correlation id header (x-correlation-id) is optional while making API calls.  
    correlation_id = (0...12).map { (48 + rand(10)).chr }.join
    headers = {'content-type'=> 'application/json', 'x-pay-token'=> xpay_token, 'accept' => 'application/json', 'x-correlation-id'=> "#{correlation_id}_SC"}
    begin
      response = RestClient::Request.execute(
      :method => :post,
      :url => url,
      :headers => headers,
      :payload => @paymentAuthorizationRequest
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
      assert(false, "Payment Authorization test failed")
    end
  end
end