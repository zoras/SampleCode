<?php

namespace Vdp;

class GetPaymentDataTest extends HttpClient {
	
	public function testGetPaymentInfo() {
		$baseUrl = "wallet-services-web/";
		$resourcePath = "payment/data/{callId}";
		$resourcePath = str_replace("{callId}",$this->conf ['VDP'] ['checkoutCallId'],$resourcePath);
		$queryString = "apikey=".$this->conf ['VDP'] ['apiKey'];
		$statusCode = $this->doXPayTokenCall ( 'get', $baseUrl, $resourcePath, $queryString, 'Get Payment Information Test', '');
		$this->assertEquals($statusCode, "200");
	}
}