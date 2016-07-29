using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Configuration;
using System.Collections.Generic;

namespace Vdp
{
    [TestClass]
    public class ManagePortfoliosTest
    {
        private AbstractVisaAPIClient abstractVisaAPIClient;

        public ManagePortfoliosTest()
        {
            abstractVisaAPIClient = new AbstractVisaAPIClient();
        }

        [TestMethod]
        public void TestPortfolios()
        {
            string baseUri = "vta/";
            string resourcePath = "v3/communities/" + ConfigurationManager.AppSettings["vtaCommunityCode"] + "/portfolios";
            Dictionary<string, string> headers = new Dictionary<string, string>();
            headers.Add("ServiceId", ConfigurationManager.AppSettings["vtaServiceId"]);
            string status = abstractVisaAPIClient.DoMutualAuthCall(baseUri + resourcePath, "GET", "Get Portfolio Details Test", "", headers);
            Assert.AreEqual(status, "OK");
        }
    }
}
