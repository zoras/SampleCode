<?php

namespace Vdp;

class GetPaymentDataTest extends \PHPUnit_Framework_TestCase {
	
	public function setUp() {
		$this->conf = parse_ini_file ( "configuration.ini", true );
		$this->abstractVisaAPIClient = new AbstractVisaAPIClient;
	}
	
	public function testGetPaymentInfo() {
		$baseUrl = "wallet-services-web/";
		$resourcePath = "payment/data/{callId}";
		$resourcePath = str_replace("{callId}",$this->conf ['VDP'] ['checkoutCallId'],$resourcePath);
		$queryString = "apikey=".$this->conf ['VDP'] ['apiKey'];
		$statusCode = $this->abstractVisaAPIClient->doXPayTokenCall ( 'get', $baseUrl, $resourcePath, $queryString, 'Get Payment Information Test', '');
		$this->assertEquals($statusCode, "200");
	}
}