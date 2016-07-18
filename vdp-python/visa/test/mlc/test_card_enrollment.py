from visa.test.helpers.vdp_client_utils import VDPTestCaseClient
import json
'''
@author: visa
'''

class TestCardEnrollement(VDPTestCaseClient):

    def setUp(self):
        self.enrollement_data = json.loads('''{
                    "enrollmentMessageType": "enroll",
                    "enrollmentRequest": {
                        "cardholderMobileNumber": "0016504323000",
                        "clientMessageID": "''' + self.config.get('VDP','mlcClientMessageID') +'''",
                        "deviceId": "''' + self.config.get('VDP','mlcDeviceId') +'''",
                        "issuerId": "''' + self.config.get('VDP','mlcIssuerId') +'''",
                        "primaryAccountNumber": "''' + self.config.get('VDP','mlcPrimaryAccountNumber') +'''"
                    }
                }''')
    
    def test_enrollement(self):
        base_uri = 'mlc/'
        resource_path = 'enrollment/v1/enrollments'
        response = self.do_mutual_auth_request(base_uri + resource_path, self.enrollement_data, 'MLC Card Enrollement Test', 'post')
        self.assertEqual(str(response.status_code) ,"200" ,"MLC enrollment's test failed")
        pass
