from visa.test.helpers.vdp_client_utils import VDPTestCaseClient
import json
'''
@author: visa
'''

class TestFundsTransferAttributes(VDPTestCaseClient):

    def setUp(self):
        self.funds_transfer_inquiry = json.loads('''{
          "acquirerCountryCode": "840",
          "acquiringBin": "408999",
          "primaryAccountNumber": "4957030420210512",
          "retrievalReferenceNumber": "330000550000",
          "systemsTraceAuditNumber": "451006"
        }''')
    
    def test_funds_transfer_inquiry(self):
        base_uri = 'paai/'
        resource_path = 'fundstransferattinq/v1/cardattributes/fundstransferinquiry'
        response = self.do_mutual_auth_request(base_uri + resource_path, self.funds_transfer_inquiry, 'Funds Transfer Inquiry call', 'post')
        self.assertEqual(str(response.status_code) ,"200" ,"Funds transfer inquiry test failed")
        pass
