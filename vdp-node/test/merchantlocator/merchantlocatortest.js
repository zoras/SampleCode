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

describe('Merchant Locator Test', function() {
	var strDate = new Date().toISOString().replace(/Z/, '');
	var locatorRequest = JSON.stringify({
        "header": {
            "messageDateTime": strDate,
            "requestMessageId": "Request_001",
            "startIndex": "0"
        },
        "searchAttrList": {
            "merchantName": "Starbucks",
            "merchantCountryCode": "840",
            "latitude": "37.363922",
            "longitude": "-121.929163",
            "distance": "2",
            "distanceUnit": "M"
        },
        "responseAttrList": [
        "GNLOCATOR"
        ],
        "searchOptions": {
            "maxRecords": "5",
            "matchIndicators": "true",
            "matchScore": "true"
        }
    });
	
	it('Merchant Locator API Test',function(done) {
		this.timeout(10000);
		console.log("Request Body : " + JSON.stringify(JSON.parse(locatorRequest),null,4));
		var baseUri = 'merchantlocator/';
		var resourcePath = 'v1/locator';
		console.log("URL : " + config.visaUrl + baseUri + resourcePath);
		req.post({
			uri : config.visaUrl + baseUri + resourcePath,
			key: fs.readFileSync(keyFile),  
			cert: fs.readFileSync(certificateFile),
			headers: {
				'Content-Type' : 'application/json',
				'Accept' : 'application/json',
				'Authorization' : 'Basic ' + new Buffer(userId + ':' + password).toString('base64'),
				'x-correlation-id' : randomstring.generate({length:12, charset: 'alphanumeric'}) + '_SC'
			},
			body: locatorRequest
		}, function(error, response, body) {
			if (!error) {
				console.log("Response Code: " + response.statusCode);
				console.log("Headers:");
				for(var item in response.headers) {
					console.log(item + ": " + response.headers[item]);
				}
				console.log("Body: "+ JSON.stringify(JSON.parse(body),null,4));
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