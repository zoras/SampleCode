package com.visa.vdp.vctc;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.testng.Assert;
import org.apache.http.HttpStatus;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;

import com.visa.vdp.utils.AbstractClient;
import com.visa.vdp.utils.Property;
import com.visa.vdp.utils.VisaProperties;

public class TestConsumerRules extends AbstractClient{
	
	String cardRegisterData;
	
	@BeforeTest(groups = "vctc")
	public void setup() {
		this.cardRegisterData = 
				"{"
					 + "\"primaryAccountNumber\": \""+ VisaProperties.getProperty(Property.VCTC_TEST_PAN) +"\""
				+ "}";
	}
	
	@Test(groups = "vctc")
	public void testRegisterACard() throws Exception {
	    String baseUri = "vctc/";
	    String resourcePath = "customerrules/v1/consumertransactioncontrols";
	    
	    CloseableHttpResponse response = doMutualAuthPostRequest(baseUri + resourcePath, "Register A Card", this.cardRegisterData);
	    Assert.assertTrue((response.getStatusLine().getStatusCode() == HttpStatus.SC_OK || response.getStatusLine().getStatusCode() == HttpStatus.SC_CREATED));
	    response.close();
	}

}
