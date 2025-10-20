// Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/io;
import ballerinax/ai.azure.index as index;

configurable string serviceUrl = ?;
configurable string apiKey = ?;
configurable string indexName = "my-test-index";

public function main() returns error? {
    // Initialize the Azure Search client
    final index:Client azureSearchClient = check new (string `${serviceUrl}/indexes/${indexName}`);
    
    // Example 1: Search for documents
    io:println("=== Searching for documents ===");
    check searchDocuments(azureSearchClient, "technology");
    
    // Example 2: Get document count
    io:println("\n=== Getting document count ===");
    check getDocumentCount(azureSearchClient);
}

function searchDocuments(index:Client 'client, string searchTerm) returns error? {
    index:DocumentsSearchGetHeaders headers = {"api-key": apiKey};
    
    index:SearchDocumentsResult searchDocumentsResult = check 'client->documentsSearchGet(headers,
        api\-version = "2025-09-01",
        search = searchTerm,
        \$count = true,
        \$select = ["content"]
    );
    
    index:SearchResult[] documents = searchDocumentsResult.value;
    io:println(string`Found ${documents.length()} documents for "${searchTerm}":`);
    foreach index:SearchResult doc in documents {
        io:println(doc.toJsonString());
    }
}

function getDocumentCount(index:Client 'client) returns error? {
    index:DocumentsCountHeaders headers = {"api-key": apiKey};
    
    int count = check 'client->documentsCount(headers, api\-version = "2025-09-01");
    io:println(string`Total documents in index: ${count}`);
}
