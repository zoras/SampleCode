<?php

namespace Vdp;

class CybersourcePaymentsTest extends HttpClient {
	
	public function setUp() {
		$this->paymentAuthorizationRequest = json_encode ( [ 
	    'amount' => '0',
	    'currency' => 'USD',
	    'payment' => [
	      'cardNumber'=> '4111111111111111',
	      'cardExpirationMonth' => '10',
	      'cardExpirationYear' => '2016'
	    ]
	    ] );
	}
	public function testPaymentAuthorizations() {
		$baseUrl = "cybersource/";
		$resourcePath = "payments/v1/authorizations";
		$queryString = "apikey=".$this->conf ['VDP'] ['apiKey'];
		$statusCode = $this->doXPayTokenCall ( 'post', $baseUrl, $resourcePath, $queryString, 'Cybersource Payments Test', $this->paymentAuthorizationRequest );
		$this->assertEquals($statusCode, "201");
	}
}