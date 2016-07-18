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

public class TestUpdatePaymentInformation extends AbstractClient {

	 String apiKey;
	 String updatePaymentInfoRequest;
	 
	 @BeforeTest(groups = "visacheckout")
	 public void setup() {
		 this.apiKey = VisaProperties.getProperty(Property.API_KEY);
		 this.updatePaymentInfoRequest = "{"
		                 + "\"orderInfo\": {"
		                 + "\"currencyCode\": \"USD\","
		                 + "\"discount\": \"5.25\","
		                 + "\"eventType\": \"Confirm\","
		                 + "\"giftWrap\": \"10.1\","
		                 + "\"misc\": \"3.2\","
		                 + "\"orderId\": \"testorderID\","
		                 + "\"promoCode\": \"testPromoCode\","
		                 + "\"reason\": \"Order Successfully Created\","
		                 + "\"shippingHandling\": \"5.1\","
		                 + "\"subtotal\": \"80.1\","
		                 + "\"tax\": \"7.1\","
		                 + "\"total\": \"101\""
		               + "}"
		            + "}";
	 }
	 
	 @Test(groups = "visacheckout")
	 public void testUpdatePaymentInfo() throws SignatureException, IOException, KeyManagementException, UnrecoverableKeyException, NoSuchAlgorithmException, KeyStoreException, CertificateException {
	     String baseUri = "wallet-services-web/";
	     String resourcePath = "payment/info/{callId}";
	     resourcePath = StringUtils.replace(resourcePath, "{callId}", VisaProperties.getProperty(Property.CHECKOUT_CALL_ID));
	     
	     CloseableHttpResponse response = doXPayTokenPutRequest(baseUri, resourcePath, "apikey=" + this.apiKey, "Update Payment Information Test", this.updatePaymentInfoRequest);
	     Assert.assertEquals(response.getStatusLine().getStatusCode(), HttpStatus.SC_OK);
	     response.close();
	 }
}
