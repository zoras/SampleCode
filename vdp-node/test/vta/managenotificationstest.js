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

describe('Manage Notifications', function() {
	
	var notificationSubscriptionRequest = JSON.stringify({
        "contactType": config.vtaNotificationContactType,
        "contactValue": "john@visa.com",
        "emailFormat": "None",
        "last4": config.vtaCreateCustomerLastFour,
        "phoneCountryCode": "en-us",
        "platform": "None",
        "preferredLanguageCode": config.vtaPreferredLanguageCode,
        "serviceOffering": "WelcomeMessage",
        "serviceOfferingSubType": "WelcomeMessage",
        "substitutions": {}
     });

	it('Notification Subscriptions Test',function(done) {
		this.timeout(10000);
		console.log("Request Body : " + JSON.stringify(JSON.parse(notificationSubscriptionRequest),null,4));

		var baseUri = 'vta/';
		var resourcePath = 'v3/communities/'+ config.vtaCommunityCode +'/portfolios/' + config.vtaPortfolioNumber +'/customers/' + config.vtaCustomerId+ '/notifications';
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
			body : notificationSubscriptionRequest
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