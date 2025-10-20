_Authors_: @SasinduDilshara \
_Created_: 2025/10/20 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Azure AI Search Index API.
The OpenAPI specification is obtained from the [Azure REST API Specifications](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/search/data-plane/Azure.Search/stable/2025-09-01/searchindex.json).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. **Replaced external error response references with local error schema definitions**:

   - **Changed**: All error response references in the `paths` section

   - **Original**:

      ```json
      "$ref": "../../../../../common-types/data-plane/v1/types.json#/definitions/ErrorResponse"
      ```

   - **Updated**:

      ```json
      "$ref": "#/definitions/ErrorResponse"
      ```

   - **Reason**: External references to common Azure types can cause issues during client generation. By internalizing the error response schemas, the specification becomes self-contained and more compatible with code generation tools.

2. **Added local error schema definitions to the `definitions` section**:

   - **Added Schemas**: `ErrorDetail`, `ErrorResponse`, `ErrorAdditionalInfo`

   - **New Definitions**:
      - `ErrorDetail`: Contains error code, message, target, details array, and additional info
      - `ErrorResponse`: Standard Azure Resource Manager error response format (also follows OData error response format)
      - `ErrorAdditionalInfo`: Contains additional error information with type and info properties

   - **Reason**: These schemas provide complete error handling capabilities without external dependencies, ensuring the OpenAPI specification is self-contained and can be used independently.

3. **Removed all `x-ms-examples` references**:

   - **Removed From**: All operation definitions in the `paths` section

   - **Original**:

      ```json
      "x-ms-examples": {
        "SearchIndexCountDocuments": {
          "$ref": "./examples/SearchIndexCountDocuments.json"
        }
      }
      ```

   - **Updated**: Completely removed the `x-ms-examples` sections

   - **Reason**: External example references can cause issues during client generation and may not be necessary for basic API functionality. Removing these references makes the specification cleaner and more portable.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/openapi.json --mode client --license docs/license.txt -o ballerina
```
