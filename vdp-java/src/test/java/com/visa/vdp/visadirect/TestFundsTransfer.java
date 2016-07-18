package com.visa.vdp.visadirect;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.http.HttpStatus;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.testng.Assert;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;

import com.visa.vdp.utils.AbstractClient;

public class TestFundsTransfer extends AbstractClient {

	String pushFundsRequest;
	
	@BeforeTest(groups = "visadirect")
	public void setup() {
		SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");//dd/MM/yyyy
	    Date now = new Date();
	    String strDate = sdfDate.format(now);
		this.pushFundsRequest = 
				"{"
					+ "\"systemsTraceAuditNumber\":350420,"
					+ "\"retrievalReferenceNumber\":\"401010350420\","
					+ "\"localTransactionDateTime\":\""+strDate +"\","
					+ "\"acquiringBin\":409999,\"acquirerCountryCode\":\"101\","
					+ "\"senderAccountNumber\":\"1234567890123456\","
					+ "\"senderCountryCode\":\"USA\","
					+ "\"transactionCurrencyCode\":\"USD\","
					+ "\"senderName\":\"John Smith\","
					+ "\"senderAddress\":\"44 Market St.\","
					+ "\"senderCity\":\"San Francisco\","
					+ "\"senderStateCode\":\"CA\","
					+ "\"recipientName\":\"Adam Smith\","
					+ "\"recipientPrimaryAccountNumber\":\"4957030420210454\","
					+ "\"amount\":\"112.00\","
					+ "\"businessApplicationId\":\"AA\","
					+ "\"transactionIdentifier\":234234322342343,"
					+ "\"merchantCategoryCode\":6012,"
					+ "\"sourceOfFundsCode\":\"03\","
					+ "\"cardAcceptor\":{"
										+ "\"name\":\"John Smith\","
										+ "\"terminalId\":\"13655392\","
										+ "\"idCode\":\"VMT200911026070\","
										+ "\"address\":{"
														+ "\"state\":\"CA\","
														+ "\"county\":\"081\","
														+ "\"country\":\"USA\","
														+ "\"zipCode\":\"94105\""
											+ "}"
										+ "},"
					+ "\"feeProgramIndicator\":\"123\""
				+ "}";
	}
	
	@Test(groups = "visadirect")
	public void testPushFundsTransactions() throws Exception {
	    String baseUri = "visadirect/";
	    String resourcePath = "fundstransfer/v1/pushfundstransactions/";
	    
	    CloseableHttpResponse response = doMutualAuthPostRequest(baseUri + resourcePath, "Push Funds Transaction Test", this.pushFundsRequest);
	    Assert.assertEquals(response.getStatusLine().getStatusCode(), HttpStatus.SC_OK);
	    response.close();
	}

}
