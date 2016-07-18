package com.visa.vdp.vta;

import java.io.IOException;
import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.SignatureException;
import java.security.UnrecoverableKeyException;
import java.security.cert.CertificateException;
import java.util.HashMap;
import java.util.Map;
import org.apache.http.HttpStatus;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.testng.Assert;
import org.testng.annotations.Test;

import com.visa.vdp.utils.AbstractClient;
import com.visa.vdp.utils.Property;
import com.visa.vdp.utils.VisaProperties;

public class TestReplaceCard extends AbstractClient {

    private String replaceCardsRequest;
    
     @Test(groups = "vta")
     public void setUp() {
         this.replaceCardsRequest = "{"
                         + "\"communityCode\": \""+ VisaProperties.getProperty(Property.VTA_COMMUNITY_CODE) + "\","
                                         + "\"newCard\": {"
                                             + "\"address\":" + VisaProperties.getProperty(Property.VTA_NEW_CARD_ADDRESS)+ ","
                                             + "\"billCycleDay\": \"22\","
                                             + "\"bin\": null,"
                                             + "\"cardEnrollmentDate\": \"2016-06-10T08:36:59+00:00\","
                                             + "\"cardExpiryDate\": \""+ VisaProperties.getProperty(Property.VTA_REPLACE_EXPIRY_DATE) + "\","
                                             + "\"cardNickName\": \"My Visa 3\","
                                             + "\"cardNumber\": \""+ VisaProperties.getProperty(Property.VTA_REPLACE_CARD_NUM) + "\","
                                             + "\"cardSecurityCode\": \""+ VisaProperties.getProperty(Property.VTA_REPLACE_SCR_CODE) + "\","
                                             + "\"isActive\": true,"
                                             + "\"lastFour\": \""+ VisaProperties.getProperty(Property.VTA_REPLACE_CARD_LAST4) + "\","
                                             + "\"nameOnCard\": \"Mradul\","
                                             + "\"paused\": false,"
                                             + "\"portfolioNum\": \""+ VisaProperties.getProperty(Property.VTA_PORTFOLIO_NUMER) + "\","
                                             + "\"previousCardNumber\": null,"
                                             + "\"productId\": null,"
                                             + "\"productIdDescription\": \"Credit\","
                                             + "\"productType\": \"Credit\","
                                             + "\"productTypeExtendedCode\": \"123\","
                                             + "\"rpin\": null"
                                         + "},"
                                         + "\"oldCard\": {"
                                             + "\"address\":" + VisaProperties.getProperty(Property.VTA_CREATE_CARD_ADDRESS) + ","
                                             + "\"billCycleDay\": \"22\","
                                             + "\"bin\": null,"
                                             + "\"cardEnrollmentDate\": \"2016-06-10T08:36:59+00:00\","
                                             + "\"cardExpiryDate\": \""+ VisaProperties.getProperty(Property.VTA_CREATE_CUSTOMER_EXPR_DATE)+ "\","
                                             + "\"cardNickName\": \"My Visa 3\","
                                             + "\"cardNumber\": \""+ VisaProperties.getProperty(Property.VTA_CREATE_CUSTOMER_CARD_NUM)+ "\","
                                             + "\"cardSecurityCode\": \""+ VisaProperties.getProperty(Property.VTA_CREATE_CARD_SECURITY_CODE) + "\","
                                         + "\"isActive\": true,"
                                         + "\"lastFour\": \""+ VisaProperties.getProperty(Property.VTA_CREATE_CUSTOMER_LAST4) + "\","
                                         + "\"nameOnCard\": \"ddd\","
                                         + "\"paused\": false,"
                                         + "\"portfolioNum\": \""+ VisaProperties.getProperty(Property.VTA_PORTFOLIO_NUMER) + "\","
                                         + "\"previousCardNumber\": null,"
                                         + "\"productId\": null,"
                                         + "\"productIdDescription\": \"Credit\","
                                         + "\"productType\": \"Credit\","
                                         + "\"productTypeExtendedCode\": \"123\","
                                         + "\"rpin\": null"
                                       + "}"
                             + "}";
     }
     
     @Test(groups = "vta")
     public void testReplaceCards() throws SignatureException, IOException, KeyManagementException, UnrecoverableKeyException, NoSuchAlgorithmException, KeyStoreException, CertificateException {
         String baseUri = "vta/";
         String resourcePath = "v3/communities/"+VisaProperties.getProperty(Property.VTA_COMMUNITY_CODE) +"/cards";

         Map<String,String> headers = new HashMap<String,String>();
         headers.put("ServiceId", VisaProperties.getProperty(Property.VTA_SERVICE_ID));
         CloseableHttpResponse response = doMutualAuthPostRequest(baseUri + resourcePath, "Replace a card test", this.replaceCardsRequest, headers);
         Assert.assertEquals(response.getStatusLine().getStatusCode(), HttpStatus.SC_CREATED);
         response.close();
     }
}
