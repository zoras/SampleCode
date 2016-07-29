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
        var baseUri = 'mlc/';
        var resourcePath = 'locationupdate/v1/locations';
        abstractVisaAPIClient.doMutualAuthRequest(baseUri + resourcePath, locationsRequestBody, 'POST', {}, 
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