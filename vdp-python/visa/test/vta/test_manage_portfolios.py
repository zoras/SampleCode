from visa.test.helpers.vdp_client_utils import VDPTestCaseClient
'''
@author: visa
'''

class TestManagePortfolios(VDPTestCaseClient):
    
    def test_portfolios(self):
        base_uri = 'vta/'
        resource_path = 'v3/communities/'+ self.config.get('VDP','vtaCommunityCode') +'/portfolios'
        response = self.do_mutual_auth_request(base_uri + resource_path, '', 'Get Portfolio Details Test', 'get', {'ServiceId' : self.config.get('VDP','vtaServiceId')})
        self.assertEqual(str(response.status_code) ,"200" ,"Get Portfolio Details Test failed")
        pass