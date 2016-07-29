using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Vdp
{
    [TestClass]
    public class WatchListScreeningTest
    {
        private string watchListInquiry;
        private AbstractVisaAPIClient abstractVisaAPIClient;

        public WatchListScreeningTest()
        {
            abstractVisaAPIClient = new AbstractVisaAPIClient();
            watchListInquiry =
           "{"
                 + "\"acquirerCountryCode\": \"840\","
                 + "\"acquiringBin\": \"408999\","
                 + "\"address\": {"
                     + "\"city\": \"Bangalore\","
                     + "\"cardIssuerCountryCode\": \"IND\""
                 + "},"
                 + "\"referenceNumber\": \"430000367618\","
                 + "\"name\": \"Mohammed Qasim\""
                 + "}";
        }

        [TestMethod]
        public void TestWatchListInquiry()
        {
            string baseUri = "visadirect/";
            string resourcePath = "watchlistscreening/v1/watchlistinquiry";
            string status = abstractVisaAPIClient.DoMutualAuthCall(baseUri + resourcePath, "POST", "Watch List Inquiry Test", watchListInquiry);
            Assert.AreEqual(status, "OK");
        }
    }
}
