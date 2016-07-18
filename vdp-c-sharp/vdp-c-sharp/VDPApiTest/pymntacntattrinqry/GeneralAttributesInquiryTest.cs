using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Vdp
{
    [TestClass]
    public class GeneralAttributesInquiryTest : AbstractClient
    {
        private string generalAttributeInquiry;

        public GeneralAttributesInquiryTest()
        {
            generalAttributeInquiry =
                    "{"
                      + "\"primaryAccountNumber\": \"4856200001123821\""
                  + "}";
        }

        [TestMethod]
        public void TestGeneralAttributesEnquiry()
        {
            string baseUri = "paai/";
            string resourcePath = "generalattinq/v1/cardattributes/generalinquiry";
            string status = DoMutualAuthCall(baseUri + resourcePath, "POST", "General Attributes Inquiry Test", generalAttributeInquiry);
            Assert.AreEqual(status, "OK");
        }
    }
}
