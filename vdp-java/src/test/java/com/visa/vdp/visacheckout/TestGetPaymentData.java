package com.visa.vdp.visacheckout;

import java.io.IOException;
import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.SignatureException;
import java.security.UnrecoverableKeyException;
import java.security.cert.CertificateException;

import org.apache.commons.lang3.StringUtils;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.testng.Assert;
import org.apache.http.HttpStatus;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;

import com.visa.vdp.utils.AbstractClient;
import com.visa.vdp.utils.Property;
import com.visa.vdp.utils.VisaProperties;

public class TestGetPaymentData extends AbstractClient {

	 String apiKey;
	 
	 @BeforeTest(groups = "visacheckout")
	 public void setup() {
		 apiKey = VisaProperties.getProperty(Property.API_KEY);
	 }
	 
	 @Test(groups = "visacheckout")
	 public void testGetPaymentInfo() throws SignatureException, IOException, KeyManagementException, UnrecoverableKeyException, NoSuchAlgorithmException, KeyStoreException, CertificateException {
	     String baseUri = "wallet-services-web/";
	     String resourcePath = "payment/data/{callId}";
	     resourcePath = StringUtils.replace(resourcePath, "{callId}", VisaProperties.getProperty(Property.CHECKOUT_CALL_ID));
	     
	     CloseableHttpResponse response = doXPayTokenGetRequest(baseUri, resourcePath, "apikey=" + this.apiKey, "Get Payment Information Test");
	     Assert.assertEquals(response.getStatusLine().getStatusCode(), HttpStatus.SC_OK);
	     response.close();
	 }
}
