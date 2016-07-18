from visa.test.helpers.vdp_client_utils import VDPTestCaseClient
import json
'''
@author: visa
'''

class TestWatchListScreening(VDPTestCaseClient):

    def setUp(self):
        self.watch_list_inquiry = json.loads('''                {
                  "acquirerCountryCode": "840",
                  "acquiringBin": "408999",
                  "address": {
                      "city": "Bangalore",
                      "cardIssuerCountryCode": "IND"
                  },
                  "referenceNumber": "430000367618",
                  "name": "Mohammed Qasim"
                  }''')
    
    def test_watch_list_inquiry(self):
        base_uri = 'visadirect/'
        resource_path = 'watchlistscreening/v1/watchlistinquiry'
        response = self.do_mutual_auth_request(base_uri + resource_path, self.watch_list_inquiry, 'Watch List Inquiry Test','post')
        self.assertEqual(str(response.status_code) ,"200" ,"Watch List Inquiry test failed")
        pass
