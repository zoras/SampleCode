from visa.test.helpers.vdp_client_utils import VDPTestCaseClient
import json
import datetime
'''
@author: visa
'''

class TestVisaTravelNotificationService(VDPTestCaseClient):

    def setUp(self):
        departureDate = datetime.datetime.now().strftime("%Y-%m-%d")
        returnDate = datetime.datetime.strptime(departureDate, "%Y-%m-%d") + datetime.timedelta(days=10)
        self.travel_notification_request = json.loads('''{
            "addTravelItinerary": {
            "returnDate": "''' + returnDate.strftime("%Y-%m-%d") + '''",
            "departureDate": "''' + departureDate +'''",
            "destinations": [
                              {
                                "state": "CA",
                                "country": "840"
                              }
                            ],
            "primaryAccountNumbers": ''' + self.config.get('VDP','tnsCardNumbers') + ''',
            "userId": "Rajesh",
            "partnerBid": "''' + self.config.get('VDP','tnsPartnerBid') + '''"
            }
        }''')
    
    def test_add_travel_itenary(self):
        base_uri = 'travelnotificationservice/'
        resource_path = 'v1/travelnotification/itinerary'
        response = self.do_mutual_auth_request(base_uri + resource_path, self.travel_notification_request, 'Add Travel Itenary Test','post')
        self.assertEqual(str(response.status_code) ,"200" ,"Add travel itenary test failed")
        pass