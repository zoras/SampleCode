require 'test/unit'
require 'rest-client'
require 'json'
require 'yaml'

class LocateAtmTest < Test::Unit::TestCase
  def setup
    @strDate = Time.now.utc.strftime("%Y-%m-%dT%H:%M:%S.%3NZ")
    @config = YAML.load_file('configuration.yml')
    @atmInquiryRequest ='''{
    "requestData": {
        "culture": "en-US",
        "distance": "20",
        "distanceUnit": "mi",
        "location": {
          "address": null,
          "geocodes": null,
          "placeName": "800 metro center , foster city,ca"
        },
        "metaDataOptions": 0,
        "options": {
          "findFilters": [
            {
              "filterName": "PLACE_NAME",
              "filterValue": "FORT FINANCIAL CREDIT UNION|ULTRON INC|U.S. BANK"
            },
            {
              "filterName": "OPER_HRS",
              "filterValue": "C"
            },
            {
              "filterName": "AIRPORT_CD",
              "filterValue": ""
            },
            {
              "filterName": "WHEELCHAIR",
              "filterValue": "N"
            },
            {
              "filterName": "BRAILLE_AUDIO",
              "filterValue": "N"
            },
            {
              "filterName": "BALANCE_INQUIRY",
              "filterValue": "N"
            },
            {
              "filterName": "CHIP_CAPABLE",
              "filterValue": "N"
            },
            {
              "filterName": "PIN_CHANGE",
              "filterValue": "N"
            },
            {
              "filterName": "RESTRICTED",
              "filterValue": "N"
            },
            {
              "filterName": "PLUS_ALLIANCE_NO_SURCHARGE_FEE",
              "filterValue": "N"
            },
            {
              "filterName": "ACCEPTS_PLUS_SHARED_DEPOSIT",
              "filterValue": "N"
            },
            {
              "filterName": "V_PAY_CAPABLE",
              "filterValue": "N"
            },
            {
              "filterName": "READY_LINK",
              "filterValue": "N"
            }
          ],
          "operationName": "or",
          "range": {
            "count": 99,
            "start": 0
          },
          "sort": {
            "direction": "desc",
            "primary": "city"
          },
          "useFirstAmbiguous": true
        }
      },
      "wsRequestHeaderV2": {
        "applicationId": "VATMLOC",
        "correlationId": "909420141104053819418",
        "requestMessageId": "test12345678",
        "requestTs": "'''+ @strDate + '''",
        "userBid": "10000108",
        "userId": "CDISIUserID"
      }
    }'''
  end
  
  def test_locateATMs
    base_uri = 'globalatmlocator/'
    resource_path = 'v1/localatms/atmsinquiry'
    url = "#{@config['visaUrl']}#{base_uri}#{resource_path}"
    user_id = @config['userId']
    password = @config['password']
    key_path = @config['key']
    cert_path = @config['cert']
    # Passing correlation id header (x-correlation-id) is optional while making API calls.  
    correlation_id = (0...12).map { (48 + rand(10)).chr }.join
    headers = {'content-type'=> 'application/json', 'accept'=> 'application/json', 'x-correlation-id'=> "#{correlation_id}_SC"}
    puts " Locate ATM test"
    puts url
    puts @atmInquiryRequest
    begin
      response = RestClient::Request.execute(
      :method => :post,
      :url => url,
      :headers => headers,
      :payload => @atmInquiryRequest,
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
      assert(false, "Locate ATM test failed")
    end
  end
end