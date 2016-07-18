from visa.test.helpers.vdp_client_utils import VDPTestCaseClient
import json
import datetime
'''
@author: visa
'''

class TestMerchantLocatorAPI(VDPTestCaseClient):

    def setUp(self):
        date = datetime.datetime.now().strftime("%Y-%m-%dT%H:%M:%S.%f")[:-3]
        self.locator_request = json.loads('''{
                "header": {
                    "messageDateTime": "''' + date + '''",
                    "requestMessageId": "Request_001",
                    "startIndex": "0"
                },
                "searchAttrList": {
                    "merchantName": "Starbucks",
                    "merchantCountryCode": "840",
                    "latitude": "37.363922",
                    "longitude": "-121.929163",
                    "distance": "2",
                    "distanceUnit": "M"
                },
                "responseAttrList": [
                "GNLOCATOR"
                ],
                "searchOptions": {
                    "maxRecords": "5",
                    "matchIndicators": "true",
                    "matchScore": "true"
                }
            }''')
    
    def test_merchant_locator_API(self):
        base_uri = 'merchantlocator/'
        resource_path = 'v1/locator'
        response = self.do_mutual_auth_request(base_uri + resource_path, self.locator_request, 'Merchant Locator Test', 'post')
        self.assertEqual(str(response.status_code) ,"200" ,"Merchant locator test failed")
        pass
