require 'test/unit'
require 'rest-client'
require 'json'
require 'yaml'

class ManageNotificationsTest < Test::Unit::TestCase
  
  def setup
    @config = YAML.load_file('configuration.yml')
    @notificationSubscriptionRequest = '''{
      "contactType": "''' + @config['vtaNotificationContactType'] + '''",
      "contactValue": "john@visa.com",
      "emailFormat": "None",
      "last4": "''' + @config['vtaCreateCustomerLastFour'] + '''",
      "phoneCountryCode": "en-us",
      "platform": "None",
      "preferredLanguageCode": "''' + @config['vtaPreferredLanguageCode'] + '''",
      "serviceOffering": "WelcomeMessage",
      "serviceOfferingSubType": "WelcomeMessage",
      "substitutions": {}
    }'''
  end
  
  def test_notificationSubscription
    base_uri = 'vta/'
    resource_path = "v3/communities/#{@config['vtaCommunityCode']}/portfolios/#{@config['vtaPortfolioNumber']}/customers/#{@config['vtaCustomerId']}/notifications"
    url = "#{@config['visaUrl']}#{base_uri}#{resource_path}"
    user_id = @config['userId']
    password = @config['password']
    key_path = @config['key']
    cert_path = @config['cert']
    # Passing correlation id header (x-correlation-id) is optional while making API calls.  
    correlation_id = (0...12).map { (48 + rand(10)).chr }.join
    headers = {'content-type'=> 'application/json', 'accept'=> 'application/json', 'ServiceId' => @config['vtaServiceId'], 'x-correlation-id'=> "#{correlation_id}_SC"}
    puts "Notification Subscriptions Test"
    puts url
    puts @notificationSubscriptionRequest
    begin
      response = RestClient::Request.execute(
      :method => :post,
      :url => url,
      :headers => headers,
      :user => user_id,
      :password => password,
      :payload => @notificationSubscriptionRequest,
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
      assert(false, "Notification Subscriptions test failed")
    end
  end
end