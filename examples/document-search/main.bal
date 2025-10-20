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
configurable string indexName = "sample-documents";

public function main() returns error? {
    // Initialize the Azure Search client
    final index:Client azureSearchClient = check new (serviceUrl);
    
    // Example 1: Search for documents
    io:println("=== Searching for documents ===");
    check searchDocuments(azureSearchClient, "technology");
    
    // Example 2: Get document count
    io:println("\n=== Getting document count ===");
    check getDocumentCount(azureSearchClient);
    
    // Example 3: Get autocomplete suggestions
    io:println("\n=== Getting autocomplete suggestions ===");
    check getAutocomplete(azureSearchClient, "tech");
    
    // Example 4: Get search suggestions
    io:println("\n=== Getting search suggestions ===");
    check getSuggestions(azureSearchClient, "prog");
}

function searchDocuments(index:Client client, string searchTerm) returns error? {
    index:DocumentsSearchGetHeaders headers = {"api-key": apiKey};
    
    index:SearchDocumentsResult result = check client->documentsSearchGet(headers,
        api\-version = "2021-04-30-Preview",
        search = searchTerm,
        top = 5,
        'select = "title,content,category"
    );
    
    json[]? documents = <json[]?>result["value"];
    if documents is json[] {
        io:println(string`Found ${documents.length()} documents for "${searchTerm}":`);
        foreach json doc in documents {
            io:println(string`  - ${doc["title"]?.toString() ?: "No title"}`);
            io:println(string`    Category: ${doc["category"]?.toString() ?: "No category"}`);
            io:println(string`    Content: ${doc["content"]?.toString() ?: "No content"}`);
            io:println("");
        }
    } else {
        io:println("No documents found");
    }
}

function getDocumentCount(index:Client client) returns error? {
    index:DocumentsCountHeaders headers = {"api-key": apiKey};
    
    int count = check client->documentsCount(headers, api\-version = "2021-04-30-Preview");
    io:println(string`Total documents in index: ${count}`);
}

function getAutocomplete(index:Client client, string searchTerm) returns error? {
    index:DocumentsAutocompleteGetHeaders headers = {"api-key": apiKey};
    
    index:AutocompleteResult result = check client->documentsAutocompleteGet(headers,
        api\-version = "2021-04-30-Preview",
        search = searchTerm,
        suggesterName = "title-suggester"
    );
    
    json[]? suggestions = <json[]?>result["value"];
    if suggestions is json[] {
        io:println(string`Autocomplete suggestions for "${searchTerm}":`);
        foreach json suggestion in suggestions {
            io:println(string`  - ${suggestion["text"]?.toString() ?: "No text"}`);
        }
    } else {
        io:println("No autocomplete suggestions found");
    }
}

function getSuggestions(index:Client client, string searchTerm) returns error? {
    index:DocumentsSuggestGetHeaders headers = {"api-key": apiKey};
    
    index:SuggestDocumentsResult result = check client->documentsSuggestGet(headers,
        api\-version = "2021-04-30-Preview",
        search = searchTerm,
        suggesterName = "title-suggester"
    );
    
    json[]? suggestions = <json[]?>result["value"];
    if suggestions is json[] {
        io:println(string`Search suggestions for "${searchTerm}":`);
        foreach json suggestion in suggestions {
            io:println(string`  - ${suggestion["@search.text"]?.toString() ?: "No text"}`);
            if suggestion["title"] is json {
                io:println(string`    Title: ${suggestion["title"]?.toString() ?: "No title"}`);
            }
        }
    } else {
        io:println("No search suggestions found");
    }
}
