<?php

namespace Vdp;

class ManageCommunitiesTest extends HttpClient {
	
	public function testGetCommunities() {
		$baseUrl = "vta/";
		$resourcePath = "v3/communities";
		$statusCode = $this->doMutualAuthCall( 'get', $baseUrl.$resourcePath, 'Get Communities Test', '', array("ServiceId: ".$this->conf['VDP'] ['vtaServiceId'] ));
		$this->assertEquals($statusCode, "200");
	}
}