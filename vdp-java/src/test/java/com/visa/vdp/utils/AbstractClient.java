package com.visa.vdp.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.SignatureException;
import java.security.UnrecoverableKeyException;
import java.security.cert.CertificateException;
import java.util.Map;
import java.util.Map.Entry;
import javax.net.ssl.SSLContext;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpHeaders;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.ssl.SSLContexts;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;

public class AbstractClient {
    
    final static Logger logger = Logger.getLogger(AbstractClient.class);
    
    private static CloseableHttpClient mutualAuthHttpClient;
    private static CloseableHttpClient XPayHttpClient;
    
    private CloseableHttpClient fetchXPayHttpClient() {
        XPayHttpClient = HttpClients.createDefault();
        return XPayHttpClient;
    }
    
    private CloseableHttpClient fetchMutualAuthHttpClient() throws KeyManagementException, UnrecoverableKeyException,
    NoSuchAlgorithmException, KeyStoreException, CertificateException, IOException {
        if (mutualAuthHttpClient == null) {
            mutualAuthHttpClient = HttpClients.custom().setSSLSocketFactory(getSSLSocketFactory()).build();
        }
        return mutualAuthHttpClient;
    }
    
    private SSLContext loadClientCertificate() throws KeyManagementException, UnrecoverableKeyException,
    NoSuchAlgorithmException, KeyStoreException, CertificateException, IOException {
        SSLContext sslcontext = SSLContexts.custom()
                        .loadKeyMaterial(new File(VisaProperties.getProperty(Property.KEYSTORE_PATH)),
                                        VisaProperties.getProperty(Property.KEYSTORE_PASSWORD).toCharArray(),
                                        VisaProperties.getProperty(Property.PRIVATE_KEY_PASSWORD).toCharArray())
                        .build();
        return sslcontext;
    }
    
    private SSLConnectionSocketFactory getSSLSocketFactory() throws KeyManagementException, UnrecoverableKeyException,
    NoSuchAlgorithmException, KeyStoreException, CertificateException, IOException {
        SSLConnectionSocketFactory sslSocketFactory = new SSLConnectionSocketFactory(loadClientCertificate(),
                        new String[] { "TLSv1" }, null, SSLConnectionSocketFactory.getDefaultHostnameVerifier());
        return sslSocketFactory;
    }
    
    protected CloseableHttpResponse doMutualAuthPostRequest(String path, String testInfo, String body)
                    throws ClientProtocolException, IOException, KeyManagementException, UnrecoverableKeyException,
                    NoSuchAlgorithmException, KeyStoreException, CertificateException {
        
        String url = VisaProperties.getProperty(Property.END_POINT) + path;
        
        logRequestBody(url, testInfo, body);
        
        HttpPost httpPost = new HttpPost(url);
        httpPost.setHeader(HttpHeaders.CONTENT_TYPE, "application/json");
        httpPost.setHeader(HttpHeaders.ACCEPT, "application/json");
        httpPost.setHeader(HttpHeaders.AUTHORIZATION, BasicAuthHeaderGenerator.getBasicAuthHeader());
        httpPost.setHeader("x-correlation-id", getCorrelationId());
        
        StringEntity postBodyEntity = new StringEntity(body);
        httpPost.setEntity(postBodyEntity);
        
        CloseableHttpResponse response = fetchMutualAuthHttpClient().execute(httpPost);
        logResponse(response);
        return response;
    }
    
    protected CloseableHttpResponse doMutualAuthPostRequest(String path, String testInfo, String body, Map<String, String> headers) 
                    throws KeyManagementException, UnrecoverableKeyException, ClientProtocolException, NoSuchAlgorithmException, 
                    KeyStoreException, CertificateException, IOException {
        
        String url = VisaProperties.getProperty(Property.END_POINT) + path;
        logRequestBody(url, testInfo, body);
        HttpPost httpPost = new HttpPost(url);
        httpPost.setHeader(HttpHeaders.CONTENT_TYPE, "application/json");
        httpPost.setHeader(HttpHeaders.ACCEPT, "application/json");
        httpPost.setHeader(HttpHeaders.AUTHORIZATION, BasicAuthHeaderGenerator.getBasicAuthHeader());
        httpPost.setHeader("x-correlation-id", getCorrelationId());
        
        StringEntity postBodyEntity = new StringEntity(body);
        httpPost.setEntity(postBodyEntity);
        
        if (headers.isEmpty() == false) {
            for (Entry<String, String> header : headers.entrySet()) {
                httpPost.setHeader(header.getKey(), header.getValue());
            }
        }
        
        CloseableHttpResponse response = fetchMutualAuthHttpClient().execute(httpPost);
        logResponse(response);
        return response;
    }
    
    protected CloseableHttpResponse doMutualAuthGetRequest(String path, String testInfo, Map<String,String> headers)
                    throws KeyManagementException, UnrecoverableKeyException, ClientProtocolException,
                    NoSuchAlgorithmException, KeyStoreException, CertificateException, IOException {
        String url = VisaProperties.getProperty(Property.END_POINT) + path;
        logRequestBody(url, testInfo, "");
        
        HttpGet httpGet = new HttpGet(url);
        httpGet.setHeader(HttpHeaders.ACCEPT, "application/json");
        httpGet.setHeader(HttpHeaders.AUTHORIZATION, BasicAuthHeaderGenerator.getBasicAuthHeader());
        httpGet.setHeader("x-correlation-id", getCorrelationId());
        
        if (headers.isEmpty() == false) {
            for (Entry<String, String> header : headers.entrySet()) {
                httpGet.setHeader(header.getKey(), header.getValue());
            }
        }
        
        CloseableHttpResponse response = fetchMutualAuthHttpClient().execute(httpGet);
        logResponse(response);
        return response;
    }
    
    protected CloseableHttpResponse doXPayTokenGetRequest(String baseUri, String resourcePath, String queryParams, String testInfo)
                    throws ClientProtocolException, IOException, KeyManagementException, UnrecoverableKeyException,
                    NoSuchAlgorithmException, KeyStoreException, CertificateException, SignatureException {
        
        String url = VisaProperties.getProperty(Property.END_POINT) + baseUri + resourcePath + "?" + queryParams;
        
        logRequestBody(url, testInfo, "");
        
        HttpGet httpGet = new HttpGet(url);
        String apikey = VisaProperties.getProperty(Property.API_KEY);
        httpGet.setHeader("content-type", "application/json");
        
        String xPayToken = XPayTokenGenerator.generateXpaytoken(resourcePath, "apikey=" + apikey, "");
        httpGet.setHeader("x-pay-token", xPayToken);
        httpGet.setHeader("x-correlation-id", getCorrelationId());
        
        CloseableHttpResponse response = fetchXPayHttpClient().execute(httpGet);
        logResponse(response);
        return response;
    }
    
    protected CloseableHttpResponse doXPayTokenPostRequest(String baseUri, String resourcePath, String queryParams, String testInfo, String body)
                    throws ClientProtocolException, IOException, SignatureException {
        String url = VisaProperties.getProperty(Property.END_POINT) + baseUri + resourcePath + "?" + queryParams;
        logRequestBody(url, testInfo, body);
        
        String apikey = VisaProperties.getProperty(Property.API_KEY);
        StringEntity postBodyEntity = new StringEntity(body);
        
        HttpPost httpPost = new HttpPost(url);
        httpPost.setEntity(postBodyEntity);
        httpPost.setHeader("content-type", "application/json");
        String xPayToken = XPayTokenGenerator.generateXpaytoken(resourcePath, "apikey=" + apikey, body);
        httpPost.setHeader("x-pay-token", xPayToken);
        httpPost.setEntity(postBodyEntity);
        httpPost.setHeader("x-correlation-id", getCorrelationId());
        
        CloseableHttpResponse response = fetchXPayHttpClient().execute(httpPost);
        logResponse(response);
        return response;
    }
    
    protected CloseableHttpResponse doXPayTokenPutRequest(String baseUri, String resourcePath, String queryParams, String testInfo, String body)
                    throws SignatureException, ClientProtocolException, IOException {
        
        String url = VisaProperties.getProperty(Property.END_POINT) + baseUri + resourcePath + "?" + queryParams;
        logRequestBody(url, testInfo, body);
        HttpPut httpPut = new HttpPut(url);
        
        StringEntity postBodyEntity = new StringEntity(body);
        httpPut.setEntity(postBodyEntity);
        httpPut.setHeader("content-type", "application/json");
        
        String apikey = VisaProperties.getProperty(Property.API_KEY);
        String xPayToken = XPayTokenGenerator.generateXpaytoken(resourcePath, "apikey=" + apikey, body);
        httpPut.setHeader("x-pay-token", xPayToken);
        httpPut.setEntity(postBodyEntity);
        httpPut.setHeader("x-correlation-id", getCorrelationId());
        
        CloseableHttpResponse response = fetchXPayHttpClient().execute(httpPut);
        logResponse(response);
        return response;
    }
    
    private static void logResponse(CloseableHttpResponse response) throws IOException {
        Header[] h = response.getAllHeaders();
        
        // Get the response json object
        BufferedReader rd = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
        StringBuffer result = new StringBuffer();
        String line;
        while ((line = rd.readLine()) != null) {
            result.append(line);
        }
        
        // Print the response details
        HttpEntity entity = response.getEntity();
        logger.info("Response status : " + response.getStatusLine() + "\n");
        
        logger.info("Response Headers: \n");
        
        for (int i = 0; i < h.length; i++)
            logger.info(h[i].getName() + ":" + h[i].getValue());
        logger.info("\n Response Body:");
        
        if(!StringUtils.isEmpty(result.toString())) {
            ObjectMapper mapper = getObjectMapperInstance();
            Object tree;
            try {
                tree = mapper.readValue(result.toString(), Object.class);
                logger.info("ResponseBody: " + mapper.writerWithDefaultPrettyPrinter().writeValueAsString(tree));
            } catch (JsonProcessingException e) {
                logger.error(e.getMessage());
            } catch (IOException e) {
                logger.error(e.getMessage());
            }
        }
        
        EntityUtils.consume(entity);
    }
    
    private static void logRequestBody(String URI, String testInfo, String payload) {
        ObjectMapper mapper = getObjectMapperInstance();
        Object tree;
        logger.info("URI: " + URI);
        logger.info(testInfo);
        if(!StringUtils.isEmpty(payload)) {
            try {
                tree = mapper.readValue(payload,Object.class);
                logger.info("RequestBody: " + mapper.writerWithDefaultPrettyPrinter().writeValueAsString(tree));
            } catch (JsonProcessingException e) {
                logger.error(e.getMessage());
            } catch (IOException e) {
                logger.error(e.getMessage());
            }
        }
    }
    
    /**
     * Get Correlation Id for the API Call.
     * @return correlation Id  
     */
    private String getCorrelationId() {
        //Passing correlation Id header is optional while making an API call. 
        return RandomStringUtils.random(10, true, true) + "_SC";
    }
    /**
     * Get New Instance of ObjectMapper
     * @return
     */
    protected static ObjectMapper getObjectMapperInstance() {
        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(SerializationFeature.INDENT_OUTPUT, true); // format json
        return mapper;
    }
    
}
