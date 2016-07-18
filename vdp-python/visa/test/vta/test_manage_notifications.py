from visa.test.helpers.vdp_client_utils import VDPTestCaseClient
import json
'''
@author: visa
'''

class TestManageNotifications(VDPTestCaseClient):
   
    def setUp(self):
        self.notification_subscription_request = json.loads('''{
                         "contactType": "''' + self.config.get('VDP','vtaNotificationContactType') + '''",
                         "contactValue": "john@visa.com",
                         "emailFormat": "None",
                         "last4": "''' + self.config.get('VDP','vtaCreateCustomerLastFour') + '''",
                         "phoneCountryCode": "en-us",
                         "platform": "None",
                         "preferredLanguageCode": "''' + self.config.get('VDP','vtaPreferredLanguageCode') + '''",
                         "serviceOffering": "WelcomeMessage",
                         "serviceOfferingSubType": "WelcomeMessage",
                         "substitutions": {}
                      }''')
         
    def test_notification_subscription(self):
        base_uri = 'vta/'
        resource_path = 'v3/communities/'+ self.config.get('VDP','vtaCommunityCode') +'/portfolios/' + self.config.get('VDP','vtaPortfolioNumber') +'/customers/' + self.config.get('VDP','vtaCustomerId')+ '/notifications';
        response = self.do_mutual_auth_request(base_uri + resource_path, self.notification_subscription_request, 'Notification Subscriptions Test', 'post', {'ServiceId' : self.config.get('VDP','vtaServiceId')})
        self.assertEqual(str(response.status_code) ,"201" ,"Notification Subscriptions Test failed")
        pass