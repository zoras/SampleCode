package com.visa.vdp.pymntacntattrinqry;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.testng.Assert;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;
import org.apache.http.HttpStatus;
import com.visa.vdp.utils.AbstractClient;

public class TestGeneralAttributesInquiry extends AbstractClient{
	
	String generalAttributeInquiry;
	
	@BeforeTest(groups = "paai")
	public void setup() {
		this.generalAttributeInquiry = 
					"{"
					  + "\"primaryAccountNumber\": \"4465390000029077\""
				  + "}";
	}
	
	@Test(groups = "paai")
	public void testGeneralAttributesEnquiry() throws Exception {
	    String baseUri = "paai/";
	    String resourcePath = "generalattinq/v1/cardattributes/generalinquiry";
	    
	    CloseableHttpResponse response = doMutualAuthPostRequest(baseUri + resourcePath, "General Attributes Enquiry", this.generalAttributeInquiry);
	    Assert.assertEquals(response.getStatusLine().getStatusCode(), HttpStatus.SC_OK);
	    response.close();
	}

}
