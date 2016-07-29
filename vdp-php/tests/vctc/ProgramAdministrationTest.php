<?php

namespace Vdp;

class ProgramAdministrationTest extends \PHPUnit_Framework_TestCase {
	
	public function setUp() {
		$this->abstractVisaAPIClient = new AbstractVisaAPIClient;
	}
	
	public function testRetreiveTransactionTypeControls() {
		$baseUrl = "vctc/";
		$resourcePath = "programadmin/v1/configuration/transactiontypecontrols";
		$statusCode = $this->abstractVisaAPIClient->doMutualAuthCall ( 'get', $baseUrl.$resourcePath, 'Retrieve Transaction Type Control call', '' );
		$this->assertEquals($statusCode, "200");
	}
}