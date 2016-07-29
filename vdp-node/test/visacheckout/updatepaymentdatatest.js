var request = require('request');
var xPayUtil = require('../../libs/xpayutil.js');
var abstractVisaAPIClient = require('../../libs/abstractvisapiclient.js');
var config = require('../../config/configuration.json');
var assert = require('chai').assert;
var req = request.defaults();
var randomstring = require('randomstring');

describe('Update Payment Information', function() {

	var updatePaymentInfoRequest = JSON.stringify({
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
       });
	
	it('Update Payment Data Test',function(done){
		this.timeout(10000);
		var apiKey = config.apiKey;
		var baseUri = 'wallet-services-web/';
		var resourcePath = 'payment/info/{callId}';
		resourcePath = resourcePath.replace('{callId}', config.checkoutCallId);
		var queryParams = 'apikey=' + apiKey;
		abstractVisaAPIClient.doXPayRequest(baseUri, resourcePath, queryParams, updatePaymentInfoRequest, 'PUT', {}, 
		function(err, responseCode) {
			if(!err) {
				assert.equal(responseCode, 200);
			} else {
				assert(false);
			}
			done();
		});
	});
});