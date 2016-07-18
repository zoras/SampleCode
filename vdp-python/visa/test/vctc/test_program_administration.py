from visa.test.helpers.vdp_client_utils import VDPTestCaseClient
'''
@author: visa
'''

class TestProgramAdministration(VDPTestCaseClient):
    
    def test_retrieve_transaction(self):
        base_uri = 'vctc/'
        resource_path = 'programadmin/v1/configuration/transactiontypecontrols'
        response = self.do_mutual_auth_request(base_uri + resource_path, '', 'Retrieve Transaction Type Control call', 'get')
        self.assertEqual(str(response.status_code) ,"200" ,"Retrieve transaction type control test failed")
        pass