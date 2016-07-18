package com.visa.vdp.visadirect;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.log4j.Logger;
import org.testng.Assert;
import org.apache.http.HttpStatus;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;

import com.visa.vdp.utils.AbstractClient;

public class TestWatchListScreening extends AbstractClient {
	
	String watchListInquiry;

	final static Logger logger = Logger.getLogger(TestWatchListScreening.class);
	
	@BeforeTest(groups = "visadirect")
	public void setup() {
		this.watchListInquiry = 
			"{"
			     + "\"acquirerCountryCode\": \"840\","
				 + "\"acquiringBin\": \"408999\","
				 + "\"address\": {"
				 	+ "\"city\": \"Bangalore\","
				 	+ "\"cardIssuerCountryCode\": \"IND\""
				 + "},"
				 + "\"referenceNumber\": \"430000367618\","
				 + "\"name\": \"Mohammed Qasim\""
				 + "}";
	}
	
	@Test(groups = "visadirect")
	public void testWatchListInquiry() throws Exception {
	    String baseUri = "visadirect/";
	    String resourcePath = "watchlistscreening/v1/watchlistinquiry";
	    
	    CloseableHttpResponse response = doMutualAuthPostRequest(baseUri + resourcePath, "Watch List Inquiry Test", this.watchListInquiry);
	    Assert.assertEquals(response.getStatusLine().getStatusCode(), HttpStatus.SC_OK);
	    response.close();
	}

}
