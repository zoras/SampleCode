<?php

namespace Vdp;

class ConsumerRulesTest extends \PHPUnit_Framework_TestCase {
	
	public function setUp() {
		$this->conf = parse_ini_file ( "configuration.ini", true );
		$this->abstractVisaAPIClient = new AbstractVisaAPIClient;
		$this->cardRegisterData = json_encode ([
		  "primaryAccountNumber" => $this->conf ['VDP'] ['vctcTestPan']
	]);
	}
	
	public function testRegisterACard() {
		$baseUrl = "vctc/";
		$resourcePath = "customerrules/v1/consumertransactioncontrols";
		$statusCode = $this->abstractVisaAPIClient->doMutualAuthCall ( 'post', $baseUrl.$resourcePath, 'Register a card call', $this->cardRegisterData );
		$this->assertTrue(($statusCode == "200" || $statusCode == "201"));
	}
}