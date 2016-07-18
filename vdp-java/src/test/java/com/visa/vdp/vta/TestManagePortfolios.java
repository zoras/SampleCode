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
import org.apache.log4j.Logger;
import org.testng.Assert;
import org.apache.http.HttpStatus;
import org.testng.annotations.Test;

import com.visa.vdp.utils.AbstractClient;
import com.visa.vdp.utils.Property;
import com.visa.vdp.utils.VisaProperties;

public class TestManagePortfolios extends AbstractClient {

     final static Logger logger = Logger.getLogger(TestManagePortfolios.class);
     
     @Test(groups = "vta")
     public void testPortfolios() throws SignatureException, IOException, KeyManagementException, UnrecoverableKeyException, NoSuchAlgorithmException, KeyStoreException, CertificateException {
         String baseUri = "vta/";
         String resourcePath = "v3/communities/"+VisaProperties.getProperty(Property.VTA_COMMUNITY_CODE) +"/portfolios";

         Map<String,String> headers = new HashMap<String,String>();
         headers.put("ServiceId", VisaProperties.getProperty(Property.VTA_SERVICE_ID));
         CloseableHttpResponse response = doMutualAuthGetRequest(baseUri + resourcePath, "Get Portfolio Details Test", headers);
         Assert.assertEquals(response.getStatusLine().getStatusCode(), HttpStatus.SC_OK);
         response.close();
     }
}
