require 'test/unit'
require 'rest-client'
require 'json'
require 'yaml'

class LocationUpdateTest < Test::Unit::TestCase
  def setup
    @strDate = Time.now.utc.strftime("%Y-%m-%dT%H:%M:%S.%LZ")
    @config = YAML.load_file('configuration.yml')
    @locationsRequestBody ='''{
    "accuracy": "5000",
    "cloudNotificationKey": "03e3ae03-a627-4241-bad6-58f811c18e46",
    "cloudNotificationProvider": "1",
    "deviceId": "'''+ @config['mlcDeviceId'] + '''",
    "deviceLocationDateTime": "'''+ @strDate + '''",
    "geoLocationCoordinate": {
      "latitude": "37.558546",
      "longitude": "-122.271079"
    },
    "header": {
      "messageDateTime": "'''+ @strDate + '''",
      "messageId": "'''+ @config['mlcMessageId'] + '''"
    },
    "issuerId": "'''+ @config['mlcIssuerId'] + '''",
    "provider": "1",
    "source": "2"
  }'''
  end
  
  def test_locationUpdate
    base_uri = 'mlc/'
    resource_path = 'locationupdate/v1/locations'
    url = "#{@config['visaUrl']}#{base_uri}#{resource_path}"
    user_id = @config['userId']
    password = @config['password']
    key_path = @config['key']
    cert_path = @config['cert']
    # Passing correlation id header (x-correlation-id) is optional while making API calls.  
    correlation_id = (0...12).map { (48 + rand(10)).chr }.join
    headers = {'content-type'=> 'application/json', 'accept'=> 'application/json', 'x-correlation-id'=> "#{correlation_id}_SC"}
    puts " Location Update test"
    puts url
    puts @locationsRequestBody
    begin
      response = RestClient::Request.execute(
      :method => :post,
      :url => url,
      :headers => headers,
      :payload => @locationsRequestBody,
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
      assert(false, "Location Update test failed")
    end
  end
end