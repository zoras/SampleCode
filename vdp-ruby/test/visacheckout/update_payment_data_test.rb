require 'test/unit'
require 'rest-client'
require 'json'
require 'yaml'
require File.expand_path('../../../lib/x_pay_utils', __FILE__)

class UpdatePaymentDataTest < Test::Unit::TestCase
  
  def setup
    @config = YAML.load_file('configuration.yml')
    @x_pay_util = XPayUtils.new
    @updatePaymentInfoRequest = '''{
      "orderInfo": {
      "currencyCode": "USD",
      "discount": "5.25",
      "eventType": "Confirm",
      "giftWrap": "10.1",
      "misc": "3.2",
      "orderId": "testorderID",
      "promoCode": "testPromoCode",
      "reason": "Order Successfully Created",
      "shippingHandling": "5.1",
      "subtotal": "80.1",
      "tax": "7.1",
      "total": "101"
      }
   }'''
  end
  
  def test_updatePaymentInfo
      base_uri = 'wallet-services-web/'
      resource_path = 'payment/info/{callId}'
      resource_path = resource_path.sub('{callId}',@config['checkoutCallId'])
      api_key = @config['apiKey']
      url = "#{@config['visaUrl']}#{base_uri}#{resource_path}?apikey=#{api_key}"
      shared_secret = @config['sharedSecret']
      query_string = "apikey=#{api_key}"
      xpay_token = @x_pay_util.get_xpay_token(resource_path,query_string,@updatePaymentInfoRequest)
      puts "Update Payment Information Test"
      puts url
      puts @updatePaymentInfoRequest
      # Passing correlation id header (x-correlation-id) is optional while making API calls.  
      correlation_id = (0...12).map { (48 + rand(10)).chr }.join
      headers = {'content-type'=> 'application/json', 'x-pay-token'=> xpay_token, 'accept' => 'application/json', 'x-correlation-id'=> "#{correlation_id}_SC"}
      begin
        response = RestClient::Request.execute(
        :method => :put,
        :url => url,
        :headers => headers,
        :payload => @updatePaymentInfoRequest
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
        assert(false, "Update Payment Information test failed")
      end
    end
end