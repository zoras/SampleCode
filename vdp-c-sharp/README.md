# C Sharp Module for Visa API calls

## Installation

VISA Api calls have been written as test cases. To run sample calls update app.config in the vdp-c-sharp folder. 

## Usage
  	 
Generate P12 file using the below command

	openssl pkcs12 -export -out p12certfile.p12 -inkey example-key.pem -in cert.pem
	
Notes: 
* Use example-key.pem as private key which you have generated at the time of creation of CSR. 
* Use cert.pem as certificate which you have downloaded from the VDP portal. 
* The above command will prompt for export password. You will need this password for invoking API.

Update app.config with the necesssary credentials. For more information on `app.config` refer :
	 
* [Manual](https://github.com/visa/SampleCode/wiki/Manual) 

Load the solution into your Visual Studio using the .sln or .csproj file.

Go to **Tests -> Debug -> All Tests**

You can see the results under the option Debug console in your output window. 

You would need to generate a Call Id for calling Visa Checkout. The documentation for generating Call Id can be found at :

* [Visa Checkout Guide](https://github.com/visa/SampleCode/wiki/Visa-Checkout)