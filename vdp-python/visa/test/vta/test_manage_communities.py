from visa.test.helpers.vdp_client_utils import VDPTestCaseClient
'''
@author: visa
'''

class TestManageCommunities(VDPTestCaseClient):
    
    def test_get_communities(self):
        base_uri = 'vta/'
        resource_path = 'v3/communities'
        response = self.do_mutual_auth_request(base_uri + resource_path, '', 'Get Communities Test', 'get', {'ServiceId' : self.config.get('VDP','vtaServiceId')})
        self.assertEqual(str(response.status_code) ,"200" ,"Get Communities Test failed")
        pass