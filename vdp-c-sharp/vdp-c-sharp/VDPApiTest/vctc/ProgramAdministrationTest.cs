using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Vdp
{
    [TestClass]
    public class ProgramAdministrationTest : AbstractClient
    {

        public ProgramAdministrationTest()
        {

        }

        [TestMethod]
        public void TestRetreiveTransactionTypeControls()
        {
            string baseUri = "vctc/";
            string resourcePath = "programadmin/v1/configuration/transactiontypecontrols";
            string status = DoMutualAuthCall(baseUri + resourcePath, "GET", "Retreive Transaction Type Controls Test", "");
            Assert.AreEqual(status, "OK");
        }
    }
}
