require 'test/unit'
require 'rest-client'
require 'json'
require 'yaml'

class ManageCustomersTest < Test::Unit::TestCase
  
  def setup
    @config = YAML.load_file('configuration.yml')
    @date = Time.now.strftime("%Y-%m-%dT%H:%M:%S.%LZ")
    @createCustomersRequest = '''{
    "customer": {
        "cards": [
            {
                "address": ''' + @config['vtaCreateCustomerAddress'] + ''',
                "billCycleDay": "7",
                "bin": 431263,
                "cardEnrollmentDate": "''' + @date + '''",
                "cardExpiryDate": "''' + @config['vtaCreateCustomerCardExpiryDate'] + '''",
                "cardNickName": "My Card",
                "cardNumber": "''' + @config['vtaCreateCustomerCardNumber'] + '''",
                "cardSecurityCode": "''' + @config['vtaCreateCustomerCardSecurityCode'] + '''",
                "contactServiceOfferings": [
                    {
                        "contact": {
                            "contactNickName": "testEmail",
                            "contactType": "Email",
                            "contactValue": "john@visa.com",
                            "isVerified": true,
                            "lastUpdateDateTime": "''' + @date + '''",
                            "mobileCountryCode": null,
                            "mobileVerificationCode": null,
                            "mobileVerificationCodeDate": "''' + Time.now.strftime("%Y-%m-%dT%H:%M:%S")+ '''",
                            "platform": "None",
                            "preferredEmailFormat": "Html",
                            "securityPhrase": null,
                            "status": "Active"
                        },
                        "serviceOfferings": [
                            {
                                "isActive": true,
                                "offeringId": "Threshold",
                                "offeringProperties": [
                                    {
                                        "key": "ThresholdAmount",
                                        "value": "10"
                                    }
                                ]
                            },
                            {
                                "isActive": true,
                                "offeringId": "CrossBorder",
                                "offeringProperties": [
                                    {
                                        "key": "ThresholdAmount",
                                        "value": "10"
                                    }
                                ]
                            },
                            {
                                "isActive": true,
                                "offeringId": "Declined",
                                "offeringProperties": [
                                    {
                                        "key": "ThresholdAmount",
                                        "value": "10"
                                    }
                                ]
                            },
                            {
                                "isActive": true,
                                "offeringId": "CardNotPresent",
                                "offeringProperties": [
                                    {
                                        "key": "ThresholdAmount",
                                        "value": "10"
                                    }
                                ]
                            }
                        ]
                    }
                ],
                "isActive": true,
                "lastFour": "''' + @config['vtaCreateCustomerLastFour'] + '''",
                "nameOnCard": "Migration",
                "paused": false,
                "portfolioNum": "''' + @config['vtaPortfolioNumber'] + '''",
                "previousCardNumber": null,
                "productId": null,
                "productIdDescription": "Credit",
                "productType": "Credit",
                "productTypeExtendedCode": "Credit",
                "rpin": null
            }
        ],
        "communityCode": "''' + @config['vtaCommunityCode'] + '''",
        "contacts": [
            {
                "contactNickName": "testEmail",
                "contactType": "Email",
                "contactValue": "john@visa.com",
                "isVerified": true,
                "lastUpdateDateTime": "''' + @date + '''",
                "mobileCountryCode": null,
                "mobileVerificationCode": null,
                "mobileVerificationCodeDate": "''' + Time.now.strftime("%Y-%m-%dT%H:%M:%S") + '''",
                "platform": "None",
                "preferredEmailFormat": "Html",
                "securityPhrase": null,
                "status": "Active"
            }
        ],
        "customerEnrollmentDate": "''' + @date + '''",
        "customerId": "a1bb6fe1-ea64-4269-b29d-169aebd8780a",
        "firstName": "James",
        "isActive": ''' + @config['vtaCreateCustomerIsActive'] + ''',
        "lastName": "Bond",
        "preferredCountryCode": "''' + @config['vtaCreateCustomerPreferedCountryCode'] + '''",
        "preferredCurrencyCode": "''' + @config['vtaCreateCustomerPreferedCurrencyCode'] + '''",
        "preferredFuelAmount": "75",
        "preferredLanguage": "''' + @config['vtaCreateCustomerPreferedLanguage'] + '''",
        "preferredTimeZone": "''' + @config['vtaCreateCustomerPreferedTimeZone'] + '''",
        "preferredTipPercentage": "15"
    }
}
    '''
  end
  
  def test_getCustomers
    base_uri = 'vta/'
    resource_path = "v3/communities/#{@config['vtaCommunityCode']}/customers"
    url = "#{@config['visaUrl']}#{base_uri}#{resource_path}"
    user_id = @config['userId']
    password = @config['password']
    key_path = @config['key']
    cert_path = @config['cert']
    # Passing correlation id header (x-correlation-id) is optional while making API calls.  
    correlation_id = (0...12).map { (48 + rand(10)).chr }.join
    headers = {'content-type'=> 'application/json', 'accept'=> 'application/json', 'ServiceId' => @config['vtaServiceId'], 'x-correlation-id'=> "#{correlation_id}_SC"}
    puts "Create Customers Request"
    puts url
    puts @createCustomersRequest
    begin
      response = RestClient::Request.execute(
      :method => :post,
      :url => url,
      :headers => headers,
      :user => user_id,
      :password => password,
      :payload => @createCustomersRequest,
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
      assert(false, "Create Customers test failed")
    end
  end
end