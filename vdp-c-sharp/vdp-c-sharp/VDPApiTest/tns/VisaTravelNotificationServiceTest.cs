using System;
using System.Configuration;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Vdp
{
    [TestClass]
    public class VisaTravelNotificationServiceTest : AbstractClient
    {
        private string travelNotificationRequest;

        public VisaTravelNotificationServiceTest()
        {
            string departureDate = DateTime.UtcNow.ToString("yyyy-MM-dd");
            string returnDate = DateTime.Now.AddDays(7).ToString("yyyy-MM-dd");
            travelNotificationRequest =
                    "{"
                        + "\"addTravelItinerary\": {"
                        + "\"returnDate\": \"" + returnDate + "\","
                        + "\"departureDate\": \"" + departureDate + "\","
                        + "\"destinations\": ["
                          + "{"
                            + "\"state\": \"CA\","
                            + "\"country\": \"840\""
                          + "}"
                        + "],"
                        + "\"primaryAccountNumbers\": " + ConfigurationManager.AppSettings["tnsCardNumbers"] + ","
                        + "\"userId\": \"Rajesh\","
                        + "\"partnerBid\": \"" + ConfigurationManager.AppSettings["tnsPartnerBid"] + "\""
                      + "}"
                    + "}";
        }

        [TestMethod]
        public void TestAddTravelItenary()
        {
            string baseUri = "travelnotificationservice/";
            string resourcePath = "v1/travelnotification/itinerary";
            string status = DoMutualAuthCall(baseUri + resourcePath, "POST", "Add Travel Itenary Test", travelNotificationRequest);
            Assert.AreEqual(status, "OK");
        }
    }
}
