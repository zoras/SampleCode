from visa.test.helpers.vdp_client_utils import VDPTestCaseClient
import json
'''
@author: visa
'''

class TestUpdatePaymentInformation(VDPTestCaseClient):
    
    def setUp(self):
        self.update_payment_info_request = json.loads('''{
                          "orderInfo": {
                          "currencyCode": "USD",
                          "discount": "5.25",
                          "eventType": "Confirm",
                          "giftWrap": "10.1",
                          "misc": "3.2",
                          "orderId": "testorderID",
                          "promoCode": "testPromoCode",
                          "reason": "Order Successfully Created",
                          "shippingHandling": "5.1",
                          "subtotal": "80.1",
                          "tax": "7.1",
                          "total": "101"
                        }
                     }''')

    def test_update_payment_info(self):
        base_uri = 'wallet-services-web/'
        resource_path = 'payment/info/{callId}'
        resource_path = resource_path.replace('{callId}', self.config.get('VDP','checkoutCallId'))
        query_string = 'apikey=' + self.config.get('VDP','apiKey')
        response = self.do_x_pay_request(base_uri, resource_path , query_string, self.update_payment_info_request, 'Update Payment Information Test', 'put')
        self.assertEqual(str(response.status_code) ,"200" ,"Update Payment Information test failed")
        pass