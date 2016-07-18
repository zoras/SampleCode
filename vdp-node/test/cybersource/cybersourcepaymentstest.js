var request = require('request');
var xPayUtil = require('../../libs/xpayutil.js');
var config = require('../../config/configuration.json');
var expect = require('chai').expect;
var req = request.defaults();
var randomstring = require('randomstring');

describe('Cybersource Payments Test', function() {
	var paymentAuthorizationRequest = JSON.stringify({
		"amount": "0",
		"currency": "USD",
		"payment": {
			"cardNumber": "4111111111111111",
			"cardExpirationMonth": "10",
			"cardExpirationYear": "2016"
		}
	});

	it('Cybersource Payments Authorization Test',function(done){
		this.timeout(10000);
		console.log("Request Body : " + JSON.stringify(JSON.parse(paymentAuthorizationRequest), null, 4));
		var apiKey = config.apiKey;
		var baseUri = 'cybersource/';
		var resourcePath = 'payments/v1/authorizations';
		var queryParams = 'apikey=' + apiKey;
		console.log("URL :" + config.visaUrl + baseUri + resourcePath + '?' + queryParams);
		req.post({
			uri : config.visaUrl + baseUri + resourcePath + '?' + queryParams,
			headers: {
				'content-type' : 'application/json',
				'x-pay-token' : xPayUtil.getXPayToken(resourcePath, queryParams, paymentAuthorizationRequest),
				'x-correlation-id' : randomstring.generate({length:12, charset: 'alphanumeric'}) + '_SC'
			},
			body: paymentAuthorizationRequest
		}, function(error, response, body) {
			if (!error) {
				console.log("Response Code: " + response.statusCode);
				console.log("Headers:");
				for(var item in response.headers) {
					console.log(item + ": " + response.headers[item]);
				}
				console.log("Body: "+ JSON.stringify(JSON.parse(body), null, 4));
				assert.equal(response.statusCode, 201);
			} else {
				console.log(error);
				assert(false);
			}
			done();
		}
		);
	});
});