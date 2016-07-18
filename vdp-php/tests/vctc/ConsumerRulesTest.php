<?php

namespace Vdp;

class ConsumerRulesTest extends HttpClient {
	
	public function setUp() {
		$this->cardRegisterData = json_encode ([
		  "primaryAccountNumber" => $this->conf ['VDP'] ['vctcTestPan']
	]);
	}
	
	public function testRegisterACard() {
		$baseUrl = "vctc/";
		$resourcePath = "customerrules/v1/consumertransactioncontrols";
		$statusCode = $this->doMutualAuthCall ( 'post', $baseUrl.$resourcePath, 'Register a card call', $this->cardRegisterData );
		$this->assertTrue(($statusCode == "200" || $statusCode == "201"));
	}
}