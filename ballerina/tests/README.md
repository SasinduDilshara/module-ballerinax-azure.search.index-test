<!-- # Running Tests

## Prerequisites

You need an API key from Azure AI Search service and the service URL.

To obtain these, refer to the [Ballerina Azure AI Index Connector](https://github.com/ballerina-platform/module-ballerinax-ai.azure.index/blob/main/ballerina/Module.md).

## Test Environments

There are two test environments for running the `ai.azure.index` connector tests. The default environment is a mock server for the Azure AI Search API. The other environment is the actual Azure AI Search API.

You can run the tests in either of these environments, and each has its own compatible set of tests.

| Test Groups | Environment                                              |
|-------------|----------------------------------------------------------|
| mock_tests  | Mock server for Azure AI Search API (Default Environment) |
| live_tests  | Azure AI Search API                                       |

## Running Tests in the Mock Server

To execute the tests on the mock server, ensure that the `isLiveServer` environment variable is either set to `false` or left unset before initiating the tests.

This environment variable can be configured within the `Config.toml` file located in the `tests` directory or specified as an environment variable.

### Using a `Config.toml` File

Create a `Config.toml` file in the `tests` directory with the following content:

```toml
isLiveServer = false
```

### Using Environment Variables

Alternatively, you can set the environment variable directly.

For Linux or macOS:

```bash
export IS_LIVE_SERVER=false
```

For Windows:

```bash
setx IS_LIVE_SERVER false
```

Then, run the following command to execute the tests:

```bash
./gradlew clean test
```

## Running Tests Against the Azure AI Search Live API

### Using a `Config.toml` File

Create a `Config.toml` file in the `tests` directory and add your authentication credentials:

```toml
isLiveServer = true
serviceUrl = "<your-azure-search-service-url>"
apiKey = "<your-azure-search-api-key>"
```

### Using Environment Variables

Alternatively, you can set your authentication credentials as environment variables.

For Linux or macOS:

```bash
export IS_LIVE_SERVER=true
export AZURE_SEARCH_SERVICE_URL="<your-azure-search-service-url>"
export AZURE_SEARCH_API_KEY="<your-azure-search-api-key>"
```

For Windows:

```bash
setx IS_LIVE_SERVER true
setx AZURE_SEARCH_SERVICE_URL <your-azure-search-service-url>
setx AZURE_SEARCH_API_KEY <your-azure-search-api-key>
```

Then, run the following command to execute the tests:

```bash
./gradlew clean test
```
