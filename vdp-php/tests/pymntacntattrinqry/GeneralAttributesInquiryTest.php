<?php

namespace Vdp;

class GeneralAttributesInquiryTest extends \PHPUnit_Framework_TestCase {
	
	public function setUp() {
		$this->abstractVisaAPIClient = new AbstractVisaAPIClient;
		$this->generalAttributeInquiry = json_encode ( [
		  "primaryAccountNumber" => "4465390000029077"
	]);
	}
	public function testGeneralAttributesEnquiry() {
		$baseUrl = "paai/";
		$resourcePath = "generalattinq/v1/cardattributes/generalinquiry";
		$statusCode = $this->abstractVisaAPIClient->doMutualAuthCall ( 'post', $baseUrl.$resourcePath, 'General Attributes Inquiry call', $this->generalAttributeInquiry );
		$this->assertEquals($statusCode, "200");
	}
}