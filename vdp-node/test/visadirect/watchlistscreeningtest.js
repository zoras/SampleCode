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

describe('Visa Direct Watch List Screening test', function() {
	var watchListInquiry = JSON.stringify({
		  "acquirerCountryCode": "840",
		  "acquiringBin": "408999",
		  "address": {
		    "city": "Bangalore",
		    "cardIssuerCountryCode": "IND"
		  },
		  "referenceNumber": "430000367618",
		  "name": "Mohammed Qasim"
		});
	
	it('Watch List Inquiry Test',function(done) {
		this.timeout(10000);
		console.log("Request Body : " + JSON.stringify(JSON.parse(watchListInquiry),null,4));
		var baseUri = 'visadirect/';
		var resourcePath = 'watchlistscreening/v1/watchlistinquiry';
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
			body: watchListInquiry
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