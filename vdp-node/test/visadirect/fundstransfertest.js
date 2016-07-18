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

describe('Visa Direct Push Funds Transactions test', function() {
	var strDate = new Date().toISOString().replace(/\..+/, '');
	var pushFundsRequest = JSON.stringify({
		  "systemsTraceAuditNumber": 350420,
		  "retrievalReferenceNumber": "401010350420",
		  "localTransactionDateTime": strDate,
		  "acquiringBin": 409999,
		  "acquirerCountryCode": "101",
		  "senderAccountNumber": "1234567890123456",
		  "senderCountryCode": "USA",
		  "transactionCurrencyCode": "USD",
		  "senderName": "John Smith",
		  "senderAddress": "44 Market St.",
		  "senderCity": "San Francisco",
		  "senderStateCode": "CA",
		  "recipientName": "Adam Smith",
		  "recipientPrimaryAccountNumber": "4957030420210454",
		  "amount": "112.00",
		  "businessApplicationId": "AA",
		  "transactionIdentifier": 234234322342343,
		  "merchantCategoryCode": 6012,
		  "sourceOfFundsCode": "03",
		  "cardAcceptor": {
		    "name": "John Smith",
		    "terminalId": "13655392",
		    "idCode": "VMT200911026070",
		    "address": {
		      "state": "CA",
		      "county": "081",
		      "country": "USA",
		      "zipCode": "94105"
		    }
		  },
		  "feeProgramIndicator": "123"
		});
	
	it('Push Funds Transaction Test',function(done) {
		this.timeout(10000);
		console.log("Request Body : " + JSON.stringify(JSON.parse(pushFundsRequest),null,4));
		var baseUri = 'visadirect/';
		var resourcePath = 'fundstransfer/v1/pushfundstransactions';
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
			body: pushFundsRequest
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