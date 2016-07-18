package com.visa.vdp.mlc;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.testng.Assert;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;

import org.apache.http.HttpStatus;
import com.visa.vdp.utils.AbstractClient;
import com.visa.vdp.utils.Property;
import com.visa.vdp.utils.VisaProperties;

public class TestCardholderEnrollment extends AbstractClient{

	String enrollementData;

	@BeforeTest(groups = "mlc")
	public void setup() {
		this.enrollementData = 
			"{"
             +      "\"enrollmentMessageType\": \"enroll\","
             +      "\"enrollmentRequest\": {"
             +      "\"cardholderMobileNumber\": \"0016504323000\","
             +      "\"clientMessageID\": \""+ VisaProperties.getProperty(Property.MLC_CLIENT_MESSAGE_ID)+ "\","
             +      "\"deviceId\": \""+ VisaProperties.getProperty(Property.MLC_DEVICE_ID)+ "\","
             +      "\"issuerId\": \""+ VisaProperties.getProperty(Property.MLC_ISSUER_ID)+ "\","
             +       "\"primaryAccountNumber\": \""+ VisaProperties.getProperty(Property.MLC_PRIMARY_ACCOUNT_NUMBER)+ "\""
             +      "}"
             +   "}";
	}

	@Test(groups = "mlc")
	public void testCardEnrollment() throws Exception {
	    String baseUri = "mlc/";
	    String resourcePath = "enrollment/v1/enrollments";
	    
	    CloseableHttpResponse response = doMutualAuthPostRequest(baseUri + resourcePath, "Card Enrollment Test", this.enrollementData);
	    Assert.assertEquals(response.getStatusLine().getStatusCode(), HttpStatus.SC_OK);
	    response.close();
	}

}
