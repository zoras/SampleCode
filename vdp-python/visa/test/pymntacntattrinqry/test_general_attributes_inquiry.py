from visa.test.helpers.vdp_client_utils import VDPTestCaseClient
import json
'''
@author: visa
'''

class TestGeneralAttributesEnquiry(VDPTestCaseClient):

    def setUp(self):
        self.general_attribute_inquiry = json.loads('''{
          "primaryAccountNumber": "4465390000029077"
        }''')
    
    def test_general_attributes_inquiry(self):
        base_uri = 'paai/'
        resource_path = 'generalattinq/v1/cardattributes/generalinquiry'
        response = self.do_mutual_auth_request(base_uri + resource_path, self.general_attribute_inquiry, 'General Attributes Inquiry call', 'post')
        self.assertEqual(str(response.status_code) ,"200" ,"General attributes inquiry test failed")
        pass
