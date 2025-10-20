# Document Search Example

This example demonstrates how to use the Azure AI Search Index connector to search for documents in an Azure Search index.

## Features Demonstrated

1. **Document Search**: Search for documents based on text queries
2. **Document Count**: Get the total number of documents in an index
3. **Autocomplete**: Get autocomplete suggestions for search terms
4. **Search Suggestions**: Get search suggestions with metadata

## Prerequisites

### 1. Azure AI Search Service

You need an active Azure AI Search service instance. To create one:

- Sign in to the [Azure Portal](https://portal.azure.com)
- Navigate to "Create a resource" → "AI + Machine Learning" → "Search service"
- Configure the following settings:
  - **Resource group**: Create new or select existing
  - **Service name**: Choose a unique name (will be part of your service URL)
  - **Location**: Select a region close to your users
  - **Pricing tier**: Choose based on your needs (Free tier available for testing)
- Review and create the service
- Wait for deployment to complete (usually takes a few minutes)

### 2. Search Index with Documents

You need a properly configured search index containing documents to search. The index should include:

**Index Schema Requirements:**
- **Fields**: Define searchable fields like `title`, `content`, `category`
- **Key field**: A unique identifier field (usually `id`)
- **Searchable fields**: Mark relevant fields as searchable
- **Retrievable fields**: Mark fields you want to return in search results
- **Suggester**: Configure a suggester for autocomplete functionality

**Sample Documents Structure:**
```json
{
  "id": "1",
  "title": "Document Title",
  "content": "Document content text...",
  "category": "Technology",
  "lastUpdated": "2023-10-01"
}
```

**Creating and Populating the Index:**
- Use Azure Portal's "Import data" wizard, or
- Use REST API calls to create the index schema, or
- Use Azure SDKs to programmatically create and populate the index

### 3. API Key for Authentication

You need an admin API key to perform search operations:

**To obtain the API key:**
- Go to your Azure AI Search service in the Azure Portal
- Navigate to "Settings" → "Keys" in the left sidebar
- Copy either the **Primary admin key** or **Secondary admin key**
- Store this key securely as it provides full access to your search service

**API Key Security:**
- Never commit API keys to source control
- Use environment variables or secure configuration files
- Rotate keys periodically for security
- Consider using query keys for read-only operations in production

**Service URL Format:**
Your service URL will be: `https://[your-service-name].search.windows.net`

## Configuration

Create a `Config.toml` file with the following configuration:

```toml
serviceUrl = "https://your-search-service.search.windows.net"
apiKey = "your-api-key"
indexName = "your-index-name"
```

## Running the Example

```bash
bal run
```

## Expected Output

The example will demonstrate:
- Searching for documents containing "technology"
- Getting the total document count
- Getting autocomplete suggestions for "tech"
- Getting search suggestions for "prog"

Each operation will display the results in a formatted manner showing how to work with the Azure AI Search Index connector.
