<?php

namespace Vdp;

class ManagePortfoliosTest extends HttpClient {
	
	public function testPortfolios() {
		$baseUrl = "vta/";
		$resourcePath = "v3/communities/".$this->conf['VDP'] ['vtaCommunityCode']."/portfolios";
		$statusCode = $this->doMutualAuthCall( 'get', $baseUrl.$resourcePath, 'Get Portfolio Details Test', '', array("ServiceId: ".$this->conf['VDP'] ['vtaServiceId'] ));
		$this->assertEquals($statusCode, "200");
	}
}