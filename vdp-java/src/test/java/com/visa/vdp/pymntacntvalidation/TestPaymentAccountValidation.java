package com.visa.vdp.pymntacntvalidation;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.testng.Assert;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;
import org.apache.http.HttpStatus;
import com.visa.vdp.utils.AbstractClient;

public class TestPaymentAccountValidation extends AbstractClient{
	
	String paymentAccountValidation;
	
	@BeforeTest(groups = "pav")
	public void setup() {
		this.paymentAccountValidation = 
				"{"
						  + "\"acquirerCountryCode\": \"840\","
						  + "\"acquiringBin\": \"408999\","
						  + "\"addressVerificationResults\": {"
						    + "\"postalCode\": \"T4B 3G5\","
						    + "\"street\": \"801 Metro Center Blv\""
						  + "},"
						  + "\"cardAcceptor\": {"
						    + "\"address\": {"
						      + "\"city\": \"San Francisco\","
						      + "\"country\": \"USA\","
						      + "\"county\": \"CA\","
						      + "\"state\": \"CA\","
						      + "\"zipCode\": \"94404\""
						    + "},"
						    + "\"idCode\": \"111111\","
						    + "\"name\": \"rohan\","
						    + "\"terminalId\": \"123\""
						  + "},"
						  + "\"cardCvv2Value\": \"672\","
						  + "\"cardExpiryDate\": \"2018-06\","
						  + "\"primaryAccountNumber\": \"4957030000313108\","
						  + "\"retrievalReferenceNumber\": \"015221743720\","
						  + "\"systemsTraceAuditNumber\": \"743720\""
				+ "}";
	}
	
	@Test(groups = "pav")
	public void testCardValidation() throws Exception {
	    String baseUri = "pav/";
	    String resourcePath = "v1/cardvalidation";
	    
	    CloseableHttpResponse response = doMutualAuthPostRequest(baseUri + resourcePath, "Card Validation Test", this.paymentAccountValidation);
	    Assert.assertEquals(response.getStatusLine().getStatusCode(), HttpStatus.SC_OK);
	    response.close();
	}

}
