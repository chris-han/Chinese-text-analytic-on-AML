# Chinese-text-analytic-on-AML
Using R with Azure Machine Learning for Chinese text analytics

The experiment leveraging JiebaR package by Qin wenfeng for Chinese word segmentations:
https://github.com/qinwf/jiebaR

You need Microsoft Azure Machinese Learning Studio account to play with it:
https://studio.azureml.net/

OData Endpoint Address
https://ussouthcentral.services.azureml.net/odata/workspaces/ed92dffcd0724f1991aa01acc940fc67/services/d9fc21a410cf4dc6a5521114e85a0346


HTTP POST
https://ussouthcentral.services.azureml.net/workspaces/ed92dffcd0724f1991aa01acc940fc67/services/d9fc21a410cf4dc6a5521114e85a0346/execute?api-version=2.0&details=true
 
Here's my sample C# client code with my app key:
M1N3c9NUSRHqEspoM6x6Io3je05sc/+xUuXSMXN4PbNnVyO/KhNaZOP41yOsDaBt+b/k9x2jdtoDXK6yDo+W7w==


// This code requires the Nuget package Microsoft.AspNet.WebApi.Client to be installed.
// Instructions for doing this in Visual Studio:
// Tools -> Nuget Package Manager -> Package Manager Console
// Install-Package Microsoft.AspNet.WebApi.Client

using System;
using System.Collections.Generic;
using System.IO;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;

namespace CallRequestResponseService
{

    public class StringTable
    {
        public string[] ColumnNames { get; set; }
        public string[,] Values { get; set; }
    }

    class Program
    {
        static void Main(string[] args)
        {
            InvokeRequestResponseService().Wait();
        }

        static async Task InvokeRequestResponseService()
        {
            using (var client = new HttpClient())
            {
                var scoreRequest = new
                {

                    Inputs = new Dictionary<string, StringTable> () { 
                        { 
                            "WebInput", 
                            new StringTable() 
                            {
                                ColumnNames = new string[] {"Col1"},
                                Values = new string[,] {  { "value" },  { "value" },  }
                            }
                        },
                                        },
                                    GlobalParameters = new Dictionary<string, string>() {
        { "WebInputText", "" },
}
                };
                const string apiKey = "M1N3c9NUSRHqEspoM6x6Io3je05sc/+xUuXSMXN4PbNnVyO/KhNaZOP41yOsDaBt+b/k9x2jdtoDXK6yDo+W7w=="; // Replace this with the API key for the web service
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue( "Bearer", apiKey);

                client.BaseAddress = new Uri("https://ussouthcentral.services.azureml.net/workspaces/ed92dffcd0724f1991aa01acc940fc67/services/d9fc21a410cf4dc6a5521114e85a0346/execute?api-version=2.0&details=true");
                
                // WARNING: The 'await' statement below can result in a deadlock if you are calling this code from the UI thread of an ASP.Net application.
                // One way to address this would be to call ConfigureAwait(false) so that the execution does not attempt to resume on the original context.
                // For instance, replace code such as:
                //      result = await DoSomeTask()
                // with the following:
                //      result = await DoSomeTask().ConfigureAwait(false)


                HttpResponseMessage response = await client.PostAsJsonAsync("", scoreRequest);

                if (response.IsSuccessStatusCode)
                {
                    string result = await response.Content.ReadAsStringAsync();
                    Console.WriteLine("Result: {0}", result);
                }
                else
                {
                    Console.WriteLine(string.Format("The request failed with status code: {0}", response.StatusCode));

                    // Print the headers - they include the requert ID and the timestamp, which are useful for debugging the failure
                    Console.WriteLine(response.Headers.ToString());

                    string responseContent = await response.Content.ReadAsStringAsync();
                    Console.WriteLine(responseContent);
                }
            }
        }
    }
}




