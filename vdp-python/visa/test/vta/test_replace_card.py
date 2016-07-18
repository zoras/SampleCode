from visa.test.helpers.vdp_client_utils import VDPTestCaseClient
import json
'''
@author: visa
'''

class TestReplaceCard(VDPTestCaseClient):
    
    def setUp(self):
        self.replace_cards_request = json.loads('''{
            "communityCode": "''' + self.config.get('VDP','vtaCommunityCode') + '''",
            "newCard": {
                "address": '''+ self.config.get('VDP','vtaReplaceCardNewAddress') + ''',
                "billCycleDay": "22",
                "bin": null,
                "cardEnrollmentDate": "2016-06-10T08:36:59+00:00",
                "cardExpiryDate": "''' + self.config.get('VDP','vtaReplaceCardExpiryDate') + '''",
                "cardNickName": "My Visa 3",
                "cardNumber": "''' + self.config.get('VDP','vtaReplaceCardNumber') + '''",
                "cardSecurityCode": "''' + self.config.get('VDP','vtaReplaceCardSecurityCode') + '''",
                "isActive": true,
                "lastFour": "''' + self.config.get('VDP','vtaReplaceCardLastFour') + '''",
                "nameOnCard": "Mradul",
                "paused": false,
                "portfolioNum": "''' + self.config.get('VDP','vtaPortfolioNumber') + '''",
                "previousCardNumber": null,
                "productId": null,
                "productIdDescription": "Credit",
                "productType": "Credit",
                "productTypeExtendedCode": "123",
                "rpin": null
            },
            "oldCard": {
                "address": '''+ self.config.get('VDP','vtaCreateCustomerAddress') + ''',
                "billCycleDay": "22",
                "bin": null,
                "cardEnrollmentDate": "2016-06-10T08:36:59+00:00",
                "cardExpiryDate": "''' + self.config.get('VDP','vtaCreateCustomerCardExpiryDate') + '''",
                "cardNickName": "My Visa 3",
                "cardNumber": "''' + self.config.get('VDP','vtaCreateCustomerCardNumber')+ '''",
                "cardSecurityCode": "''' + self.config.get('VDP','vtaCreateCustomerCardSecurityCode') + '''",
            "isActive": true,
            "lastFour": "'''+ self.config.get('VDP','vtaCreateCustomerLastFour') + '''",
            "nameOnCard": "Mradul",
            "paused": false,
            "portfolioNum": "''' + self.config.get('VDP','vtaPortfolioNumber') + '''",
            "previousCardNumber": null,
            "productId": null,
            "productIdDescription": "Credit",
            "productType": "Credit",
            "productTypeExtendedCode": "123",
            "rpin": null
          }
}''')
    
    def test_get_communities(self):
        base_uri = 'vta/'
        resource_path = 'v3/communities/' +  self.config.get('VDP','vtaCommunityCode') + '/cards'
        response = self.do_mutual_auth_request(base_uri + resource_path, self.replace_cards_request, 'Replace a card test', 'post', {'ServiceId' : self.config.get('VDP','vtaServiceId')})
        self.assertEqual(str(response.status_code) ,"201" ,"Replace a card test failed")
        pass