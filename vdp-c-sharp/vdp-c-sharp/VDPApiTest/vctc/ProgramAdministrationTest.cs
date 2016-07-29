using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Vdp
{
    [TestClass]
    public class ProgramAdministrationTest
    {
        private AbstractVisaAPIClient abstractVisaAPIClient;

        public ProgramAdministrationTest()
        {
            abstractVisaAPIClient = new AbstractVisaAPIClient();
        }

        [TestMethod]
        public void TestRetreiveTransactionTypeControls()
        {
            string baseUri = "vctc/";
            string resourcePath = "programadmin/v1/configuration/transactiontypecontrols";
            string status = abstractVisaAPIClient.DoMutualAuthCall(baseUri + resourcePath, "GET", "Retreive Transaction Type Controls Test", "");
            Assert.AreEqual(status, "OK");
        }
    }
}
