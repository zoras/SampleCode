package com.visa.vdp.vctc;

import java.util.HashMap;

import org.apache.http.client.methods.CloseableHttpResponse;
import org.testng.Assert;
import org.apache.http.HttpStatus;
import org.testng.annotations.Test;

import com.visa.vdp.utils.AbstractClient;

public class TestProgramAdministration extends AbstractClient{
	
	
	@Test(groups = "vctc")
	public void testRetreiveTransactionTypeControls() throws Exception {
	    String baseUri = "vctc/";
	    String resourcePath = "programadmin/v1/configuration/transactiontypecontrols";
	    
	    CloseableHttpResponse response = doMutualAuthGetRequest(baseUri + resourcePath, "Retrieve Transaction Type Controls", new HashMap<String, String>());
	    Assert.assertEquals(response.getStatusLine().getStatusCode(), HttpStatus.SC_OK);
	    response.close();
	}

}
