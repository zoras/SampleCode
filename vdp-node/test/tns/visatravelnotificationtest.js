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

describe('Visa Travel Notification Service Test', function() {
	var departureDate = new Date();
	var returnDate = new Date();
	returnDate.setDate(returnDate.getDate() + 7);
	var travelNotificationRequest = JSON.stringify({
            "addTravelItinerary": {
            "returnDate" : returnDate.toISOString().replace(/T.*$/, ''),
            "departureDate" : departureDate.toISOString().replace(/T.*$/, ''),
            "destinations": [
                              {
                                "state": "CA",
                                "country": "840"
                              }
                            ],
            "primaryAccountNumbers": config.tnsCardNumbers,
            "userId": "Rajesh",
            "partnerBid": config.tnsPartnerBid
            }
        });
	
	it('Add Travel Itenary Test',function(done) {
		this.timeout(10000);
		console.log("Request Body : " + JSON.stringify(JSON.parse(travelNotificationRequest),null,4));
		var baseUri = 'travelnotificationservice/';
		var resourcePath = 'v1/travelnotification/itinerary';
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
			body: travelNotificationRequest
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