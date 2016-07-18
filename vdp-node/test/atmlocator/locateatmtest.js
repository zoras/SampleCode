var request = require('request');
var fs = require('fs');
var config = require('../../config/configuration.json');
var assert = require('chai').assert;
var randomstring = require('randomstring');

var req = request.defaults();
var userId = config.userId ;
var password = config.password;
var keyFile = config.key;
var certificateFile = config.cert;

describe('ATM Locator test', function() {
	var strDate = new Date().toISOString();
	var atmInquiryRequest = JSON.stringify({
		"requestData": {
			"culture": "en-US",
			"distance": "20",
			"distanceUnit": "mi",
			"location": {
				"address": null,
				"geocodes": null,
				"placeName": "800 metro center , foster city,ca"
			},
			"metaDataOptions": 0,
			"options": {
				"findFilters": [
				                {
				                	"filterName": "PLACE_NAME",
				                	"filterValue": "FORT FINANCIAL CREDIT UNION|ULTRON INC|U.S. BANK"
				                },
				                {
				                	"filterName": "OPER_HRS",
				                	"filterValue": "C"
				                },
				                {
				                	"filterName": "AIRPORT_CD",
				                	"filterValue": ""
				                },
				                {
				                	"filterName": "WHEELCHAIR",
				                	"filterValue": "N"
				                },
				                {
				                	"filterName": "BRAILLE_AUDIO",
				                	"filterValue": "N"
				                },
				                {
				                	"filterName": "BALANCE_INQUIRY",
				                	"filterValue": "N"
				                },
				                {
				                	"filterName": "CHIP_CAPABLE",
				                	"filterValue": "N"
				                },
				                {
				                	"filterName": "PIN_CHANGE",
				                	"filterValue": "N"
				                },
				                {
				                	"filterName": "RESTRICTED",
				                	"filterValue": "N"
				                },
				                {
				                	"filterName": "PLUS_ALLIANCE_NO_SURCHARGE_FEE",
				                	"filterValue": "N"
				                },
				                {
				                	"filterName": "ACCEPTS_PLUS_SHARED_DEPOSIT",
				                	"filterValue": "N"
				                },
				                {
				                	"filterName": "V_PAY_CAPABLE",
				                	"filterValue": "N"
				                },
				                {
				                	"filterName": "READY_LINK",
				                	"filterValue": "N"
				                }
				                ],
				                "operationName": "or",
				                "range": {
				                	"count": 99,
				                	"start": 0
				                },
				                "sort": {
				                	"direction": "desc",
				                	"primary": "city"
				                },
				                "useFirstAmbiguous": true
			}
		},
		"wsRequestHeaderV2": {
			"applicationId": "VATMLOC",
			"correlationId": "909420141104053819418",
			"requestMessageId": "test12345678",
			"requestTs": strDate,
			"userBid": "10000108",
			"userId": "CDISIUserID"
		}
	});

	it('Locate ATM Test', function(done) {
		this.timeout(10000);
		console.log("Request Body : " + JSON.stringify(JSON.parse(atmInquiryRequest), null, 4));
		var baseUri = 'globalatmlocator/';
		var resourcePath = 'v1/localatms/atmsinquiry';
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
			body: atmInquiryRequest
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