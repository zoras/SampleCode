<?php

namespace Vdp;

class ValidationTest extends HttpClient {
	
	public function testRetreiveListofDecisionRecords() {
		$baseUrl = "vctc/";
		$resourcePath = "validation/v1/decisions/history";
		$queryParams = "?limit=1&page=1";
		$statusCode = $this->doMutualAuthCall ( 'get', $baseUrl.$resourcePath.$queryParams, 'Retrieve List of Recent Decision Records call', '' );
		$this->assertEquals($statusCode, "200");
	}
}