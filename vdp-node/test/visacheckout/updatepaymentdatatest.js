var request = require('request');
var xPayUtil = require('../../libs/xpayutil.js');
var config = require('../../config/configuration.json');
var expect = require('chai').expect;
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
	
	it('Update Payment Date Test',function(done){
		this.timeout(10000);
		console.log("Request Body : " + JSON.stringify(JSON.parse(updatePaymentInfoRequest),null,4));
		var apiKey = config.apiKey;
		var baseUri = 'wallet-services-web/';
		var resourcePath = 'payment/info/{callId}';
		resourcePath = resourcePath.replace('{callId}', config.checkoutCallId);
		var queryParams = 'apikey=' + apiKey;
		console.log("URL :" + config.visaUrl + baseUri + resourcePath + '?' + queryParams);
		req.put({
			uri : config.visaUrl + baseUri + resourcePath + '?' + queryParams,
			headers: {
				'content-type' : 'application/json',
				'x-pay-token' : xPayUtil.getXPayToken(resourcePath, queryParams, updatePaymentInfoRequest),
				'x-correlation-id' : randomstring.generate({length:12, charset: 'alphanumeric'}) + '_SC'
			},
			body : updatePaymentInfoRequest
		}, function(error, response, body) {
			if (!error) {
				console.log("Response Code: " + response.statusCode);
				console.log("Headers:");
				for(var item in response.headers) {
					console.log(item + ": " + response.headers[item]);
				}
				if (body !== null && body !== '') {
					console.log("Body: "+ JSON.stringify(JSON.parse(body), null, 4));
				}
				assert.equal(response.statusCode, 200);
			} else {
				console.log(error);
				assert(false);
			}
			done();
		}
		);
	});
});