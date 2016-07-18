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

import org.apache.http.client.methods.CloseableHttpResponse;
import org.testng.Assert;
import org.apache.http.HttpStatus;
import org.testng.annotations.Test;

import com.visa.vdp.utils.AbstractClient;
import com.visa.vdp.utils.Property;
import com.visa.vdp.utils.VisaProperties;

public class TestManageNotifications extends AbstractClient {
    
    private String notificationSubscriptionRequest;
    
    @Test(groups = "vta")
    public void setUp() {
        this.notificationSubscriptionRequest = "{"
                        + "\"contactType\":  \""+ VisaProperties.getProperty(Property.VTA_CONTACT_TYPE)+ "\","
                        + "\"contactValue\":  \"john@visa.com\","
                        + "\"emailFormat\": \"None\","
                        + "\"last4\":  \""+ VisaProperties.getProperty(Property.VTA_CREATE_CUSTOMER_LAST_FOUR)+ "\","
                        + "\"phoneCountryCode\": \"en-us\","
                        + "\"platform\": \"None\","
                        + "\"preferredLanguageCode\":  \""+ VisaProperties.getProperty(Property.VTA_PREFFERED_LANGUAGE_CODE)+ "\","
                        + "\"serviceOffering\":  \"WelcomeMessage\","
                        + "\"serviceOfferingSubType\":  \"WelcomeMessage\","
                        + "\"substitutions\": {}"
                     + "}";
    }

     @Test(groups = "vta")
     public void testNotificationSubscription() throws SignatureException, IOException, KeyManagementException, UnrecoverableKeyException, NoSuchAlgorithmException, KeyStoreException, CertificateException {
         String baseUri = "vta/";
         String resourcePath = "v3/communities/"+VisaProperties.getProperty(Property.VTA_COMMUNITY_CODE) +"/portfolios/" 
                         + VisaProperties.getProperty(Property.VTA_PORTFOLIO_NUMER) +"/customers/" + VisaProperties.getProperty(Property.VTA_CUSTOMER_ID)
                         + "/notifications";

         Map<String,String> headers = new HashMap<String,String>();
         headers.put("ServiceId", VisaProperties.getProperty(Property.VTA_SERVICE_ID));
         
         CloseableHttpResponse response = doMutualAuthPostRequest(baseUri + resourcePath, "Notification Subscriptions Test", this.notificationSubscriptionRequest, headers);
         Assert.assertEquals(response.getStatusLine().getStatusCode(), HttpStatus.SC_CREATED);
         response.close();
     }
}
