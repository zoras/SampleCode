<?php

namespace Vdp;

class CardholderEnrollmentTest extends HttpClient {
	
	public function setUp() {
		$this->enrollementData = json_encode ([
		  "enrollmentMessageType" => "enroll",
		  "enrollmentRequest" => [
		    "cardholderMobileNumber" => "0016504323000",
		    "clientMessageID" => $this->conf ['VDP'] ['mlcClientMessageID'],
		    "deviceId" => $this->conf ['VDP'] ['mlcDeviceId'],
		    "issuerId" => $this->conf ['VDP'] ['mlcIssuerId'],
		    "primaryAccountNumber" => $this->conf ['VDP'] ['mlcPrimaryAccountNumber']
		  ]
		]);
	}
	
	public function testCardEnrollment() {
		$baseUrl = "mlc/";
		$resourcePath = "enrollment/v1/enrollments";
		$statusCode = $this->doMutualAuthCall ( 'post', $baseUrl.$resourcePath, 'MLC Card Enrollement Test', $this->enrollementData );
		$this->assertEquals($statusCode, "200");
	}
}