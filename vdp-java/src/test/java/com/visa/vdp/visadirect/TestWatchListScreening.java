package com.visa.vdp.visadirect;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.testng.Assert;

import java.util.HashMap;

import org.apache.http.HttpStatus;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;

import com.visa.vdp.utils.AbstractVisaAPIClient;
import com.visa.vdp.utils.MethodTypes;

public class TestWatchListScreening {
	
	String watchListInquiry;
	AbstractVisaAPIClient abstractVisaAPIClient;
	
	@BeforeTest(groups = "visadirect")
	public void setup() {
		this.abstractVisaAPIClient = new AbstractVisaAPIClient();
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
	    
	    CloseableHttpResponse response = this.abstractVisaAPIClient.doMutualAuthRequest(baseUri + resourcePath, "Watch List Inquiry Test", this.watchListInquiry, MethodTypes.POST, new HashMap<String, String>());
	    Assert.assertEquals(response.getStatusLine().getStatusCode(), HttpStatus.SC_OK);
	    response.close();
	}

}
