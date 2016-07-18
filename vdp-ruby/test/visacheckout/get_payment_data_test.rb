require 'test/unit'
require 'rest-client'
require 'json'
require 'yaml'
require File.expand_path('../../../lib/x_pay_utils', __FILE__)

class GetPaymentDataTest < Test::Unit::TestCase
  
  def setup
    @config = YAML.load_file('configuration.yml')
    @x_pay_util = XPayUtils.new
  end
  
  def test_getPaymentInfo
      base_uri = 'wallet-services-web/'
      resource_path = 'payment/data/{callId}'
      resource_path = resource_path.sub('{callId}',@config['checkoutCallId'])
      api_key = @config['apiKey']
      url = "#{@config['visaUrl']}#{base_uri}#{resource_path}?apikey=#{api_key}"
      shared_secret = @config['sharedSecret']
      query_string = "apikey=#{api_key}"
      xpay_token = @x_pay_util.get_xpay_token(resource_path,query_string,'')
      puts "Get Payment Information Test"
      puts url
      # Passing correlation id header (x-correlation-id) is optional while making API calls.  
      correlation_id = (0...12).map { (48 + rand(10)).chr }.join
      headers = {'x-pay-token'=> xpay_token, 'accept' => 'application/json', 'x-correlation-id'=> "#{correlation_id}_SC"}
      begin
        response = RestClient::Request.execute(
        :method => :get,
        :url => url,
        :headers => headers
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
        assert(false, "Get Payment Information test failed")
      end
    end
end