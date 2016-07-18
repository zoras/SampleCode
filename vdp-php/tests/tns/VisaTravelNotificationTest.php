<?php

namespace Vdp;

class VisaTravelNotificationService extends HttpClient {
	
	public function setUp() {
		$departureDate = date('Y-m-d', time());
		$returnDate = strtotime("+10 day", strtotime($departureDate));
		$returnDate = date('Y-m-d', $returnDate);
		$this->locatorRequest = json_encode ([
            "addTravelItinerary" => [
            "returnDate" => $returnDate,
            "departureDate" => $departureDate,
            "destinations" => [
                              [
                                "state" => "CA",
                                "country" => "840"
                              ]
                            ],
            "primaryAccountNumbers" => json_decode($this->conf ['VDP'] ['tnsCardNumbers']),
            "userId" => "Rajesh",
            "partnerBid" => $this->conf ['VDP'] ['tnsPartnerBid']
            ]
        ]);
	}
	
	public function testAddTravelItenary() {
		$baseUrl = "travelnotificationservice/";
		$resourcePath = "v1/travelnotification/itinerary";
		$statusCode = $this->doMutualAuthCall ( 'post', $baseUrl.$resourcePath, 'Add Travel Itenary Test', $this->locatorRequest );
		$this->assertEquals($statusCode, "200");
	}
}