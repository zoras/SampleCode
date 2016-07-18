from visa.test.helpers.vdp_client_utils import VDPTestCaseClient
import json
'''
@author: visa
'''

class TestCybersourcePayment(VDPTestCaseClient):

    def setUp(self):
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
        response = self.do_x_pay_request(base_uri, resource_path , query_string, self.payment_authorization_request, 'Cybersource Payments Test', 'post')
        self.assertEqual(str(response.status_code) ,"201" ,"Cybersource payments test failed")
        pass
