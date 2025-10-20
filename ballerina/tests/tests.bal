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

import ballerina/os;
import ballerina/test;

configurable boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
configurable string serviceUrl = isLiveServer ? os:getEnv("AZURE_SEARCH_SERVICE_URL") : "http://localhost:9090";
configurable string apiKey = isLiveServer ? os:getEnv("AZURE_SEARCH_API_KEY") : "test-key";
final string mockServiceUrl = "http://localhost:9090";
final Client azureSearchClient = check initClient();

function initClient() returns Client|error {
    ConnectionConfig config = {
        secureSocket: isLiveServer ? {
            cert: {
                path: "",
                password: ""
            }
        } : ()
    };
    
    if isLiveServer {
        return new (serviceUrl, config);
    }
    return new (mockServiceUrl, config);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testDocumentsCount() returns error? {
    DocumentsCountHeaders headers = {};
    if !isLiveServer {
        headers["api-key"] = apiKey;
    }
    
    int count = check azureSearchClient->documentsCount(headers, api\-version = "2021-04-30-Preview");
    test:assertTrue(count >= 0, msg = "Documents count should be non-negative");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testDocumentsSearch() returns error? {
    DocumentsSearchGetHeaders headers = {};
    if !isLiveServer {
        headers["api-key"] = apiKey;
    }
    
    SearchDocumentsResult searchResult = check azureSearchClient->documentsSearchGet(headers, 
        api\-version = "2021-04-30-Preview",
        search = "test"
    );
    test:assertTrue(searchResult["value"] is json[], msg = "Search result should contain a value array");
}

@test:Config {
    groups: ["mock_tests"]
}
isolated function testDocumentsAutocomplete() returns error? {
    DocumentsAutocompleteGetHeaders headers = {"api-key": apiKey};
    
    AutocompleteResult autocompleteResult = check azureSearchClient->documentsAutocompleteGet(headers, 
        api\-version = "2021-04-30-Preview",
        search = "test", 
        suggesterName = "test-suggester"
    );
    test:assertTrue(autocompleteResult["value"] is json[], msg = "Autocomplete result should contain a value array");
}

@test:Config {
    groups: ["mock_tests"]  
}
isolated function testDocumentsSuggest() returns error? {
    DocumentsSuggestGetHeaders headers = {"api-key": apiKey};
    
    SuggestDocumentsResult suggestResult = check azureSearchClient->documentsSuggestGet(headers, 
        api\-version = "2021-04-30-Preview",
        search = "test",
        suggesterName = "test-suggester"
    );
    test:assertTrue(suggestResult["value"] is json[], msg = "Suggest result should contain a value array");
}
