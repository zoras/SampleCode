from visa.test.helpers.vdp_client_utils import VDPTestCaseClient
import json
'''
@author: visa
'''

class TestConsumerRules(VDPTestCaseClient):

    def setUp(self):
        self.card_register_data = json.loads('''{
          "primaryAccountNumber": ''' + self.config.get('VDP','vctcTestPan') +'''
        }''')
    
    def test_register_a_card(self):
        base_uri = 'vctc/'
        resource_path = 'customerrules/v1/consumertransactioncontrols'
        response = self.do_mutual_auth_request(base_uri + resource_path, self.card_register_data, 'Register a card call', 'post')
        self.assertTrue((str(response.status_code) == "200" or str(response.status_code) == "201"),"Register a card test failed")
        pass
