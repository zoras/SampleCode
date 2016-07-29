var request = require('request');
var fs = require('fs');
var config = require('../../config/configuration.json');
var abstractVisaAPIClient = require('../../libs/abstractvisapiclient.js');
var assert = require('chai').assert;
var randomstring = require('randomstring');

var req = request.defaults();
var userId = config.userId ;
var password = config.password;
var keyFile = config.key;
var certificateFile = config.cert;

describe('Manage Communities', function() {
	
	it('Get Communities Test',function(done) {
		this.timeout(10000);
		var baseUri = 'vta/';
		var resourcePath = 'v3/communities';
		abstractVisaAPIClient.doMutualAuthRequest(baseUri + resourcePath, '', 'GET', {'ServiceId' : config.vtaServiceId}, 
		function(err, responseCode) {
			if(!err) {
				assert.equal(responseCode, 200);
			} else {
				assert(false);
			}
			done();
		});
	});
});