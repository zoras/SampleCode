package com.visa.vdp.cybersource;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.testng.Assert;
import org.apache.http.HttpStatus;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;

import com.visa.vdp.utils.AbstractClient;
import com.visa.vdp.utils.Property;
import com.visa.vdp.utils.VisaProperties;

public class TestCybersourcePayments extends AbstractClient{

	String apiKey;
	String paymentAuthorizationRequest;

	@BeforeTest(groups = "cybersource")
	public void setup() {
		this.apiKey = VisaProperties.getProperty(Property.API_KEY);
		this.paymentAuthorizationRequest = 
				"{\"amount\": \"0\","
					+ "\"currency\": \"USD\","
					+ "\"payment\": "
							+ "{ \"cardNumber\": \"4111111111111111\","
								+ "\"cardExpirationMonth\": \"10\","
								+ "\"cardExpirationYear\": \"2016\""
							+ "}"
				+ "}";
	}

	@Test(groups = "cybersource")
	public void testPaymentAuthorizations() throws Exception {
	    String baseUri = "cybersource/";
	    String resourcePath = "payments/v1/authorizations";
	    String queryString = "apikey=" + apiKey;
	    
	    CloseableHttpResponse response = doXPayTokenPostRequest(baseUri, resourcePath, queryString, "Payment Authorization Test", this.paymentAuthorizationRequest);
	    Assert.assertEquals(response.getStatusLine().getStatusCode(), HttpStatus.SC_CREATED);
	    response.close();
	}

}
