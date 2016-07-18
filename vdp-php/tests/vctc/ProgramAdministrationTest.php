<?php

namespace Vdp;

class ProgramAdministrationTest extends HttpClient {
	
	public function testRetreiveTransactionTypeControls() {
		$baseUrl = "vctc/";
		$resourcePath = "programadmin/v1/configuration/transactiontypecontrols";
		$statusCode = $this->doMutualAuthCall ( 'get', $baseUrl.$resourcePath, 'Retrieve Transaction Type Control call', '' );
		$this->assertEquals($statusCode, "200");
	}
}