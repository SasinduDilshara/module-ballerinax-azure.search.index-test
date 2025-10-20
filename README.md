# Ballerina Azure AI Index connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-ai.azure.index/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-ai.azure.index/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-ai.azure.index.svg)](https://github.com/ballerina-platform/module-ballerinax-ai.azure.index/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/ai.azure.index.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%ai.azure.index)

## Overview

[Azure AI Search](https://azure.microsoft.com/en-us/products/ai-services/cognitive-search), a cloud search service with built-in AI capabilities, provides the [Azure AI Search REST API](https://docs.microsoft.com/en-us/rest/api/searchservice/) to access its powerful search and indexing functionality for building rich search experiences.

The `ballarinax/ai.azure.index` package offers functionality to connect and interact with [Azure AI Search Index Management REST API](https://docs.microsoft.com/en-us/rest/api/searchservice/index-api) enabling seamless interaction with search indexes, documents, and search operations for building intelligent search applications.

## Setup guide

To use the Azure AI Search Index Connector, you must have access to Azure AI Search through an [Azure account](https://azure.microsoft.com/en-us/free/) and a search service resource. If you do not have an Azure account, you can sign up for one [here](https://azure.microsoft.com/en-us/free/).

#### Create an Azure AI Search Service

1. Open the [Azure Portal](https://portal.azure.com).

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

The `Azure AI Index` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-ai.azure.index/tree/main/examples/), covering the following use cases:

1. [Document search](https://github.com/ballerina-platform/module-ballerinax-ai.azure.index/tree/main/examples/document-search) - Search for documents in an Azure AI Search index with various query parameters and filters.
2. [Index management](https://github.com/ballerina-platform/module-ballerinax-ai.azure.index/tree/main/examples/index-management) - Create, update, and manage search indexes and their schemas.

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 17. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`ai.azure.index` package](https://central.ballerina.io/ballerinax/ai.azure.index/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
