package com.visa.vdp.tns;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

import org.apache.http.HttpStatus;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.testng.Assert;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.Test;

import com.visa.vdp.utils.AbstractClient;
import com.visa.vdp.utils.Property;
import com.visa.vdp.utils.VisaProperties;

public class TestVisaTravelNotificationService extends AbstractClient{

    String travelNotificationRequest;

    @BeforeTest(groups = "tns")
    public void setup() {
        
        SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy-MM-dd");
        TimeZone utc = TimeZone.getTimeZone("UTC");
        sdfDate.setTimeZone(utc);
        Date now = new Date();
        String departureDate = sdfDate.format(now);
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, 7);
        Date retDate = cal.getTime();    
        String returnDate = sdfDate.format(retDate);
        
        this.travelNotificationRequest = "{"
                        + "\"addTravelItinerary\": {"
                        + "\"returnDate\": \""+ returnDate +"\","
                        + "\"departureDate\": \""+ departureDate +"\","
                        + "\"destinations\": ["
                          + "{"
                            + "\"state\": \"CA\","
                            + "\"country\": \"840\""
                          + "}"
                        + "],"
                        + "\"primaryAccountNumbers\": "+ VisaProperties.getProperty(Property.TNS_CARD_ACCOUNT_NUMBERS) +","
                        + "\"userId\": \"Rajesh\","
                        + "\"partnerBid\": \""+ VisaProperties.getProperty(Property.TNS_PARTNER_BID) + "\""
                      + "}"
                    + "}";
    }

    @Test(groups = "tns")
    public void testAddTravelItenary() throws Exception {
        String baseUri = "travelnotificationservice/";
        String resourcePath = "v1/travelnotification/itinerary";
        
        CloseableHttpResponse response = doMutualAuthPostRequest(baseUri + resourcePath, "Add Travel Itenary Test", this.travelNotificationRequest);
        Assert.assertEquals(response.getStatusLine().getStatusCode(), HttpStatus.SC_OK);
        response.close();
    }

}
