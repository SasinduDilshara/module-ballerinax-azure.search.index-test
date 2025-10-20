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

import ballerina/http;
import ballerina/log;

listener http:Listener httpListener = new (9090);

http:Service mockService = service object {
    resource function get docs(@http:Header string api\-key, @http:Query string api\-version, @http:Query string? search = ()) returns json|http:BadRequest {
        // Validate the request
        if api\-version == "" {
            return http:BAD_REQUEST;
        }

        // Mock search response
        json response = {
            "value": [
                {
                    "id": "1",
                    "title": "Test Document 1",
                    "content": "This is a test document for Azure Search",
                    "@search.score": 0.01
                },
                {
                    "id": "2", 
                    "title": "Test Document 2",
                    "content": "Another test document for Azure Search",
                    "@search.score": 0.01
                }
            ],
            "@odata.count": 2,
            "@search.coverage": 100
        };
        return response;
    }

    resource function get docs/search\.autocomplete(@http:Header string api\-key, @http:Query string api\-version, @http:Query string search, @http:Query string suggesterName) returns json|http:BadRequest {
        // Validate the request
        if api\-version == "" || search == "" || suggesterName == "" {
            return http:BAD_REQUEST;
        }

        // Mock autocomplete response
        json response = {
            "value": [
                {"text": "test document", "queryPlusText": "test document"},
                {"text": "test data", "queryPlusText": "test data"}
            ]
        };
        return response;
    }

    resource function get docs/search\.suggest(@http:Header string api\-key, @http:Query string api\-version, @http:Query string search, @http:Query string suggesterName) returns json|http:BadRequest {
        // Validate the request
        if api\-version == "" || search == "" || suggesterName == "" {
            return http:BAD_REQUEST;
        }

        // Mock suggest response
        json response = {
            "value": [
                {
                    "@search.text": "test document suggestion",
                    "title": "Test Document",
                    "id": "1"
                }
            ]
        };
        return response;
    }
};

function init() returns error? {
    if isLiveServer {
        log:printInfo("Skipping mock server initialization as the tests are running on live server");
        return;
    }

    log:printInfo("Initiating mock server...");
    check httpListener.attach(mockService, "/");
    check httpListener.'start();
}
