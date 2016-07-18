require 'test/unit'
require 'rest-client'
require 'json'
require 'yaml'

class ReplaceCardsTest < Test::Unit::TestCase
  
  def setup
    @date = Time.now.strftime("%Y-%m-%dT%H:%M:%S.%LZ")
    @config = YAML.load_file('configuration.yml')
    @replaceCardsRequest = '''{
    "communityCode": "''' + @config['vtaCommunityCode'] + '''",
    "newCard": {
        "address": ''' + @config['vtaReplaceCardNewAddress'] + ''',
        "billCycleDay": "22",
        "bin": null,
        "cardEnrollmentDate": "2016-06-10T08:36:59+00:00",
        "cardExpiryDate": "''' + @config['vtaReplaceCardExpiryDate'] + '''",
        "cardNickName": "My Visa 3",
        "cardNumber": "''' + @config['vtaReplaceCardNumber'] + '''",
        "cardSecurityCode": "''' + @config['vtaReplaceCardSecurityCode'] + '''",
        "isActive": true,
        "lastFour": "''' + @config['vtaReplaceCardLastFour'] + '''",
        "nameOnCard": "Mradul",
        "paused": false,
        "portfolioNum": "''' + @config['vtaPortfolioNumber'] + '''",
        "previousCardNumber": null,
        "productId": null,
        "productIdDescription": "Credit",
        "productType": "Credit",
        "productTypeExtendedCode": "123",
        "rpin": null
    },
    "oldCard": {
        "address": ''' + @config['vtaCreateCustomerAddress'] + ''',
        "billCycleDay": "22",
        "bin": null,
        "cardEnrollmentDate": "2016-06-10T08:36:59+00:00",
        "cardExpiryDate": "''' + @config['vtaCreateCustomerCardExpiryDate'] + '''",
        "cardNickName": "My Visa 3",
        "cardNumber": "''' + @config['vtaCreateCustomerCardNumber'] + '''",
        "cardSecurityCode": "''' + @config['vtaCreateCustomerCardSecurityCode'] + '''",
    "isActive": true,
    "lastFour": "'''+ @config['vtaCreateCustomerLastFour'] + '''",
    "nameOnCard": "ddd",
    "paused": false,
    "portfolioNum": "''' + @config['vtaPortfolioNumber'] + '''",
    "previousCardNumber": null,
    "productId": null,
    "productIdDescription": "Credit",
    "productType": "Credit",
    "productTypeExtendedCode": "123",
    "rpin": null
  }
}'''
  end
  
  def test_replaceACard
    base_uri = 'vta/'
    resource_path = "v3/communities/#{@config['vtaCommunityCode']}/cards"
    url = "#{@config['visaUrl']}#{base_uri}#{resource_path}"
    user_id = @config['userId']
    password = @config['password']
    key_path = @config['key']
    cert_path = @config['cert']
    # Passing correlation id header (x-correlation-id) is optional while making API calls.  
    correlation_id = (0...12).map { (48 + rand(10)).chr }.join
    headers = {'content-type'=> 'application/json', 'accept'=> 'application/json', 'ServiceId' => @config['vtaServiceId'], 'x-correlation-id'=> "#{correlation_id}_SC"}
    puts "Replace a card test"
    puts url
    puts @replaceCardsRequest
    begin
      response = RestClient::Request.execute(
      :method => :post,
      :url => url,
      :headers => headers,
      :user => user_id,
      :password => password,
      :payload => @replaceCardsRequest,
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
      assert(false, "Replace a card test failed")
    end
  end
end