from visa.helpers.abstract_visa_api_client import AbstractVisaAPIClient
import json
import sys
import os
import unittest
if sys.version_info < (3, 0):
    import ConfigParser as parser
else:
    import configparser as parser
'''
@author: visa
'''

class TestCybersourcePayment(unittest.TestCase):
    
    config = parser.ConfigParser()
    config_path = os.path.abspath(os.path.join(os.path.dirname(os.path.dirname(__file__)),'..','configuration.ini'))
    config.read(config_path)
    
    def setUp(self):
        self.abstract_visa_api_client = AbstractVisaAPIClient()
        self.payment_authorization_request = json.loads('''{
        "amount": "0",
        "currency": "USD",
        "payment": {
          "cardNumber": "4111111111111111",
          "cardExpirationMonth": "10",
          "cardExpirationYear": "2016"
        }
    }''')
    
    def test_cybersource_payment_authorization(self):
        base_uri = 'cybersource/'
        resource_path = 'payments/v1/authorizations'
        query_string = 'apikey=' + self.config.get('VDP','apiKey')
        response = self.abstract_visa_api_client.do_x_pay_request(base_uri, resource_path , query_string, self.payment_authorization_request, 'Cybersource Payments Test', 'post')
        self.assertEqual(str(response.status_code) ,"201" ,"Cybersource payments test failed")
        pass
