using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Vdp
{
    [TestClass]
    public class ValidationTest : AbstractClient
    {
        public ValidationTest()
        {
           
        }

        [TestMethod]
        public void TestRetreiveListofDecisionRecords()
        {
            string baseUri = "vctc/";
            string resourcePath = "validation/v1/decisions/history";
            string queryString = "?limit=1&page=1";
            string status = DoMutualAuthCall(baseUri + resourcePath + queryString, "GET", "Retreive List of Decision Records Test", "");
            Assert.AreEqual(status, "OK");
        }
    }
}
