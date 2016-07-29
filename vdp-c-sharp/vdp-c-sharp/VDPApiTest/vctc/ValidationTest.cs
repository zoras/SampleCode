using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Vdp
{
    [TestClass]
    public class ValidationTest
    {
        private AbstractVisaAPIClient abstractVisaAPIClient;

        public ValidationTest()
        {
            abstractVisaAPIClient = new AbstractVisaAPIClient();
        }

        [TestMethod]
        public void TestRetreiveListofDecisionRecords()
        {
            string baseUri = "vctc/";
            string resourcePath = "validation/v1/decisions/history";
            string queryString = "?limit=1&page=1";
            string status = abstractVisaAPIClient.DoMutualAuthCall(baseUri + resourcePath + queryString, "GET", "Retreive List of Decision Records Test", "");
            Assert.AreEqual(status, "OK");
        }
    }
}
