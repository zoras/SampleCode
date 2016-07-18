var request = require('request');
var xPayUtil = require('../../libs/xpayutil.js');
var config = require('../../config/configuration.json');
var expect = require('chai').expect;
var req = request.defaults();
var randomstring = require('randomstring');

describe('Get Payment Data', function() {

	it('Get Payment Information Test',function(done){
		this.timeout(10000);
		var apiKey = config.apiKey;
		var baseUri = 'wallet-services-web/';
		var resourcePath = 'payment/data/{callId}';
		resourcePath = resourcePath.replace('{callId}', config.checkoutCallId);
		var queryParams = 'apikey=' + apiKey;
		console.log("URL :" + config.visaUrl + baseUri + resourcePath + '?' + queryParams);
		req.get({
			uri : config.visaUrl + baseUri + resourcePath + '?' + queryParams,
			headers: {
				'content-type' : 'application/json',
				'x-pay-token' : xPayUtil.getXPayToken(resourcePath, queryParams, ''),
				'x-correlation-id' : randomstring.generate({length:12, charset: 'alphanumeric'}) + '_SC'
			}
		}, function(error, response, body) {
			if (!error) {
				console.log("Response Code: " + response.statusCode);
				console.log("Headers:");
				for(var item in response.headers) {
					console.log(item + ": " + response.headers[item]);
				}
				console.log("Body: "+ JSON.stringify(JSON.parse(body), null, 4));
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