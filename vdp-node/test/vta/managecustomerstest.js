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

describe('Manage Customers', function() {
	var date = new Date().toISOString();
	var createCustomersRequest = JSON.stringify({
	    "customer": {
	        "cards": [
	            {
	                "address": config.vtaCreateCustomerAddress,
	                "billCycleDay": "7",
	                "bin": 431263,
	                "cardEnrollmentDate": date ,
	                "cardExpiryDate": config.vtaCreateCustomerCardExpiryDate,
	                "cardNickName": "Mradul",
	                "cardNumber": config.vtaCreateCustomerCardNumber,
	                "cardSecurityCode":  config.vtaCreateCustomerCardSecurityCode,
	                "contactServiceOfferings": [
	                    {
	                        "contact": {
	                            "contactNickName": "testEmail",
	                            "contactType": "Email",
	                            "contactValue": "john@visa.com",
	                            "isVerified": true,
	                            "lastUpdateDateTime":  date ,
	                            "mobileCountryCode": null,
	                            "mobileVerificationCode": null,
	                            "mobileVerificationCodeDate": "2016-06-10T14:53:07"  ,
	                            "platform": "None",
	                            "preferredEmailFormat": "Html",
	                            "securityPhrase": null,
	                            "status": "Active"
	                        },
	                        "serviceOfferings": [
	                            {
	                                "isActive": true,
	                                "offeringId": "Threshold",
	                                "offeringProperties": [
	                                    {
	                                        "key": "ThresholdAmount",
	                                        "value": "10"
	                                    }
	                                ]
	                            },
	                            {
	                                "isActive": true,
	                                "offeringId": "CrossBorder",
	                                "offeringProperties": [
	                                    {
	                                        "key": "ThresholdAmount",
	                                        "value": "10"
	                                    }
	                                ]
	                            },
	                            {
	                                "isActive": true,
	                                "offeringId": "Declined",
	                                "offeringProperties": [
	                                    {
	                                        "key": "ThresholdAmount",
	                                        "value": "10"
	                                    }
	                                ]
	                            },
	                            {
	                                "isActive": true,
	                                "offeringId": "CardNotPresent",
	                                "offeringProperties": [
	                                    {
	                                        "key": "ThresholdAmount",
	                                        "value": "10"
	                                    }
	                                ]
	                            }
	                        ]
	                    }
	                ],
	                "isActive": true,
	                "lastFour":  config.vtaCreateCustomerLastFour,
	                "nameOnCard": "Migration",
	                "paused": false,
	                "portfolioNum":  config.vtaPortfolioNumber,
	                "previousCardNumber": null,
	                "productId": null,
	                "productIdDescription": "Credit",
	                "productType": "Credit",
	                "productTypeExtendedCode": "Credit",
	                "rpin": null
	            }
	        ],
	        "communityCode":  config.vtaCommunityCode,
	        "contacts": [
	            {
	                "contactNickName": "testEmail",
	                "contactType": "Email",
	                "contactValue": "john@visa.com",
	                "isVerified": true,
	                "lastUpdateDateTime":  date ,
	                "mobileCountryCode": null,
	                "mobileVerificationCode": null,
	                "mobileVerificationCodeDate":  "2016-06-10T14:53:07",
	                "platform": "None",
	                "preferredEmailFormat": "Html",
	                "securityPhrase": null,
	                "status": "Active"
	            }
	        ],
	        "customerEnrollmentDate":  date ,
	        "customerId": "a1bb6fe1-ea64-4269-b29d-169aebd8780a",
	        "firstName": "James",
	        "isActive": config.vtaCreateCustomerIsActive,
	        "lastName": "Bond",
	        "preferredCountryCode":  config.vtaCreateCustomerPreferedCountryCode,
	        "preferredCurrencyCode":  config.vtaCreateCustomerPreferedCurrencyCode,
	        "preferredFuelAmount": "75",
	        "preferredLanguage":  config.vtaCreateCustomerPreferedLanguage,
	        "preferredTimeZone":  config.vtaCreateCustomerPreferedTimeZone,
	        "preferredTipPercentage": "15"
	    }
	});
	
	it('Create Customers Test',function(done) {
		this.timeout(10000);
		console.log("Request Body : " + JSON.stringify(JSON.parse(createCustomersRequest),null,4));
		var baseUri = 'vta/';
		var resourcePath = 'v3/communities/'+ config.vtaCommunityCode +"/customers";
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
			body : createCustomersRequest
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