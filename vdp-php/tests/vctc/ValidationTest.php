<?php

namespace Vdp;

class ValidationTest extends \PHPUnit_Framework_TestCase {
	
	public function setUp() {
		$this->abstractVisaAPIClient = new AbstractVisaAPIClient;
	}
	
	public function testRetreiveListofDecisionRecords() {
		$baseUrl = "vctc/";
		$resourcePath = "validation/v1/decisions/history";
		$queryParams = "?limit=1&page=1";
		$statusCode = $this->abstractVisaAPIClient->doMutualAuthCall ( 'get', $baseUrl.$resourcePath.$queryParams, 'Retrieve List of Recent Decision Records call', '' );
		$this->assertEquals($statusCode, "200");
	}
}