from visa.helpers.abstract_visa_api_client import AbstractVisaAPIClient
import json
import unittest
'''
@author: visa
'''

class TestGeneralAttributesEnquiry(unittest.TestCase):

    def setUp(self):
        self.abstract_visa_api_client = AbstractVisaAPIClient()
        self.general_attribute_inquiry = json.loads('''{
          "primaryAccountNumber": "4465390000029077"
        }''')
    
    def test_general_attributes_inquiry(self):
        base_uri = 'paai/'
        resource_path = 'generalattinq/v1/cardattributes/generalinquiry'
        response = self.abstract_visa_api_client.do_mutual_auth_request(base_uri + resource_path, self.general_attribute_inquiry, 'General Attributes Inquiry call', 'post')
        self.assertEqual(str(response.status_code) ,"200" ,"General attributes inquiry test failed")
        pass
