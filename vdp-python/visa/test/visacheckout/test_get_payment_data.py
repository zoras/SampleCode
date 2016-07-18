from visa.test.helpers.vdp_client_utils import VDPTestCaseClient
'''
@author: visa
'''

class TestGetPaymentData(VDPTestCaseClient):

    def test_get_payment_info(self):
        base_uri = 'wallet-services-web/'
        resource_path = 'payment/data/{callId}'
        resource_path = resource_path.replace('{callId}', self.config.get('VDP','checkoutCallId'))
        query_string = 'apikey=' + self.config.get('VDP','apiKey')
        response = self.do_x_pay_request(base_uri, resource_path , query_string, '', 'Get Payments Information Test', 'get')
        self.assertEqual(str(response.status_code) ,"200" ,"Get Payments Information test failed")
        pass