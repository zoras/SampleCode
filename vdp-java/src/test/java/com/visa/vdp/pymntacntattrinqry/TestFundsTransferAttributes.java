package com.visa.vdp.pymntacntattrinqry;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.testng.Assert;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;
import org.apache.http.HttpStatus;
import com.visa.vdp.utils.AbstractClient;

public class TestFundsTransferAttributes extends AbstractClient{
	
	String fundsTransferInquiry;
	
	@BeforeTest(groups = "paai")
	public void setup() {
		this.fundsTransferInquiry = 
			       "{"
					  + "\"acquirerCountryCode\": \"840\","
					  + "\"acquiringBin\": \"408999\","
					  + "\"primaryAccountNumber\": \"4957030420210512\","
					  + "\"retrievalReferenceNumber\": \"330000550000\","
					  + "\"systemsTraceAuditNumber\": \"451006\""
					+ "}";
	}
	
	@Test(groups = "paai")
	public void testFundsTransferEnquiry() throws Exception {
	    String baseUri = "paai/";
	    String resourcePath = "fundstransferattinq/v1/cardattributes/fundstransferinquiry";
	    
	    CloseableHttpResponse response = doMutualAuthPostRequest(baseUri + resourcePath, "Funds Transfer Enquiry", this.fundsTransferInquiry);
	    Assert.assertEquals(response.getStatusLine().getStatusCode(), HttpStatus.SC_OK);
	    response.close();
	}

}
