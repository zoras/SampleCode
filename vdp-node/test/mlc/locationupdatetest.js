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

describe('MLC Locations Test', function() {
	var strDate = new Date().toISOString();
	var locationsRequestBody = JSON.stringify({
		  "accuracy": "5000",
		  "cloudNotificationKey": "03e3ae03-a627-4241-bad6-58f811c18e46",
		  "cloudNotificationProvider": "1",
		  "deviceId": config.mlcDeviceId,
		  "deviceLocationDateTime": strDate,
		  "geoLocationCoordinate": {
		    "latitude": "37.558546",
		    "longitude": "-122.271079"
		  },
		  "header": {
		    "messageDateTime": strDate,
		    "messageId": config.mlcMessageId
		  },
		  "issuerId": config.mlcIssuerId,
		  "provider": "1",
		  "source": "2"
		});
	
	it('Locations Update Test',function(done) {
		this.timeout(10000);
		console.log("Request Body : " + JSON.stringify(JSON.parse(locationsRequestBody),null,4));
		var baseUri = 'mlc/';
		var resourcePath = 'locationupdate/v1/locations';
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
			body: locationsRequestBody
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