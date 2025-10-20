## Overview

[Azure AI Search](https://azure.microsoft.com/en-us/products/ai-services/cognitive-search), a cloud search service with built-in AI capabilities, provides the [Azure AI Search REST API](https://docs.microsoft.com/en-us/rest/api/searchservice/) to access its powerful search and indexing functionality for building rich search experiences.

The `ballarinax/ai.azure.index` package offers functionality to connect and interact with [Azure AI Search Index Management REST API](https://docs.microsoft.com/en-us/rest/api/searchservice/index-api) enabling seamless interaction with search indexes, documents, and search operations for building intelligent search applications.

## Setup guide

To use the Azure AI Search Index Connector, you must have access to Azure AI Search through an Azure account and a search service resource. If you do not have an Azure account, you can sign up for one at the Azure website.

### Create an Azure AI Search Service

1. Open the Azure Portal.

2. Navigate to Create a resource -> AI + Machine Learning -> Search service.

3. Fill in the required details:
   - Resource group
   - Service name
   - Location
   - Pricing tier

4. Review and create the search service.

5. Once the service is deployed, navigate to the service and obtain the service URL and Admin API keys from the "Keys" section.

6. Store the service URL and API key securely to use in your application.

## Quickstart

To use the `Azure AI Index` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

Import the `ballerinax/ai.azure.index` module.

```ballerina
import ballerinax/ai.azure.index;
```

### Step 2: Create a new connector instance

Create an `ai.azure.index:Client` with the obtained service URL and API Key and initialize the connector.

```ballerina
configurable string serviceUrl = ?;
configurable string apiKey = ?;

final ai.azure.index:Client azureSearchClient = check new(serviceUrl, {
    auth: {
        apiKey: apiKey
    }
});
```

### Step 3: Invoke the connector operation

Now, you can utilize available connector operations.

#### Search for documents in an index

```ballerina
public function main() returns error? {

    // Search for documents
    ai.azure.index:SearchResult searchResult = check azureSearchClient->documentsSearchGet({}, 
        search = "search query",
        top = 10
    );
    
    // Process search results
    foreach var document in searchResult.value {
        // Process each document
    }
}
```

### Step 4: Run the Ballerina application

```bash
bal run
```

## Examples

The `Azure AI Index` connector provides practical examples illustrating usage in various scenarios. Explore these examples, covering the following use cases:

1. [Document search](https://github.com/ballerina-platform/module-ballerinax-ai.azure.index/tree/main/examples/document-search) - Search for documents in an Azure AI Search index with various query parameters and filters.
2. [Index management](https://github.com/ballerina-platform/module-ballerinax-ai.azure.index/tree/main/examples/index-management) - Create, update, and manage search indexes and their schemas.