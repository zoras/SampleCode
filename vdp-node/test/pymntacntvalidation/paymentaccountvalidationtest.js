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

describe('Payment Account Validation Test', function() {
	var paymentAccountValidation = JSON.stringify({
		  "acquirerCountryCode": "840",
		  "acquiringBin": "408999",
		  "addressVerificationResults": {
		    "postalCode": "T4B 3G5",
		    "street": "801 Metro Center Blv"
		  },
		  "cardAcceptor": {
		    "address": {
		      "city": "San Francisco",
		      "country": "USA",
		      "county": "CA",
		      "state": "CA",
		      "zipCode": "94404"
		    },
		    "idCode": "111111",
		    "name": "rohan",
		    "terminalId": "123"
		  },
		  "cardCvv2Value": "672",
		  "cardExpiryDate": "2018-06",
		  "primaryAccountNumber": "4957030000313108",
		  "retrievalReferenceNumber": "015221743720",
		  "systemsTraceAuditNumber": "743720"
		});
	
	it('Card Validation Test',function(done) {
		this.timeout(10000);
		console.log("Request Body : " + JSON.stringify(JSON.parse(paymentAccountValidation),null,4));
		var baseUri = 'pav/';
		var resourcePath = 'v1/cardvalidation';
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
			body: paymentAccountValidation
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