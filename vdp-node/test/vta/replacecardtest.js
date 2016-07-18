var request = require('request');
var fs = require('fs');
var config = require('../../config/configuration.json');
var expect = require('chai').expect;
var randomstring = require('randomstring');

var req = request.defaults();
var userId = config.userId ;
var password = config.password;
var keyFile = config.key;
var certificateFile = config.cert;

describe('Replace Cards', function() {
	var date = new Date().toISOString();
	var replaceCardsRequest = JSON.stringify({
        "communityCode": config.vtaCommunityCode,
        "newCard": {
            "address": config.vtaReplaceCardNewAddress,
            "billCycleDay": "22",
            "bin": null,
            "cardEnrollmentDate": "2016-06-10T08:36:59+00:00",
            "cardExpiryDate": config.vtaReplaceCardExpiryDate,
            "cardNickName": "My Visa 3",
            "cardNumber": config.vtaReplaceCardNumber,
            "cardSecurityCode": config.vtaReplaceCardSecurityCode,
            "isActive": true,
            "lastFour": config.vtaReplaceCardLastFour,
            "nameOnCard": "Mradul",
            "paused": false,
            "portfolioNum": config.vtaPortfolioNumber,
            "previousCardNumber": null,
            "productId": null,
            "productIdDescription": "Credit",
            "productType": "Credit",
            "productTypeExtendedCode": "123",
            "rpin": null
        },
        "oldCard": {
            "address": config.vtaCreateCustomerAddress,
            "billCycleDay": "22",
            "bin": null,
            "cardEnrollmentDate": "2016-06-10T08:36:59+00:00",
            "cardExpiryDate": config.vtaCreateCustomerCardExpiryDate,
            "cardNickName": "My Visa 3",
            "cardNumber": config.vtaCreateCustomerCardNumber,
            "cardSecurityCode": config.vtaCreateCustomerCardSecurityCode,
        "isActive": true,
        "lastFour":  config.vtaCreateCustomerLastFour,
        "nameOnCard": "ddd",
        "paused": false,
        "portfolioNum": config.vtaPortfolioNumber,
        "previousCardNumber": null,
        "productId": null,
        "productIdDescription": "Credit",
        "productType": "Credit",
        "productTypeExtendedCode": "123",
        "rpin": null
      }
});

	it('Replace Cards Test',function(done) {
		this.timeout(10000);
		console.log("Request Body : " + JSON.stringify(JSON.parse(replaceCardsRequest),null,4));
		var baseUri = 'vta/';
		var resourcePath = 'v3/communities/'+ config.vtaCommunityCode +'/cards';
		console.log("URL : " + config.visaUrl + baseUri + resourcePath);
		req.post({
			uri : config.visaUrl + baseUri + resourcePath,
			key: fs.readFileSync(keyFile),  
			cert: fs.readFileSync(certificateFile),
			headers: {
				'Content-Type' : 'application/json',
				'Accept' : 'application/json',
				'ServiceId' : config.vtaServiceId,
				'Authorization' : 'Basic ' + new Buffer(userId + ':' + password).toString('base64'),
				'x-correlation-id' : randomstring.generate({length:12, charset: 'alphanumeric'}) + '_SC'
			},
			body : replaceCardsRequest
		}, function(error, response, body) {
			if (!error) {
				console.log("Response Code: " + response.statusCode);
				console.log("Headers:");
				for(var item in response.headers) {
					console.log(item + ": " + response.headers[item]);
				}
				console.log("Body: "+ JSON.stringify(JSON.parse(body),null,4));
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