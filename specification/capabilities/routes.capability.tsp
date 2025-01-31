import "@typespec/http";
import "@typespec/openapi";
import "./examples.capability.tsp";
import "./models.capability.tsp";
import "../auth/models.auth.tsp";
import "../common/examples.id.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

// List

@get
@route("/accounts/{accountID}/capabilities")
@tag("Capabilities")
@doc("""
  Retrieve all the capabilities an account has requested.
  
  Read our [capabilities guide](https://docs.moov.io/guides/accounts/capabilities/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/capabilities.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/capabilities.read"]>)
@opExample(#{
  parameters: #{ accountID: ExampleID },
  returnType: #{
    xRequestID: ExampleID,
    statusCode: HttpStatusOK,
    body: #[ExampleTransfersCapability, ExampleCollectFundsCapability],
  },
})
@extension("x-speakeasy-name-override", "list")
op listCapabilities(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,
): ListResponses<Capability>;

// Add

@post
@route("/accounts/{accountID}/capabilities")
@tag("Capabilities")
@doc("""
  Request capabilities for a specific account. Read our [capabilities guide](https://docs.moov.io/guides/accounts/capabilities/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/capabilities.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/capabilities.write"]>)
@opExample(#{
  parameters: #{
    accountID: ExampleID,
    body: #{ capabilities: #[CapabilityID.collectFunds] },
  },
  returnType: #{
    xRequestID: ExampleID,
    statusCode: HttpStatusOK,
    body: #[ExampleTransfersCapability, ExampleCollectFundsCapability],
  },
})
@extension("x-speakeasy-name-override", "request")
op requestCapabilities(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,

  @body body: AddCapabilities,
): PostResponses<Capability[], AddCapabilitiesError>;

// Get

@get
@route("/accounts/{accountID}/capabilities/{capabilityID}")
@tag("Capabilities")
@doc("""
  Retrieve a specific capability that an account has requested. Read our [capabilities guide](https://docs.moov.io/guides/accounts/capabilities/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/capabilities.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/capabilities.read"]>)
@opExample(#{
  parameters: #{ accountID: ExampleID, capabilityID: CapabilityID.transfers },
  returnType: #{
    xRequestID: ExampleID,
    statusCode: HttpStatusOK,
    body: ExampleTransfersCapability,
  },
})
@extension("x-speakeasy-name-override", "get")
op getCapability(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,

  @path
  capabilityID: CapabilityID,
): GetResponses<Capability>;

// Disable

@delete
@route("/accounts/{accountID}/capabilities/{capabilityID}")
@tag("Capabilities")
@doc("""
  Disable a specific capability that an account has requested. Read our [capabilities guide](https://docs.moov.io/guides/accounts/capabilities/) to learn more.
  
    To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/capabilities.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/capabilities.write"]>)
@opExample(#{
  parameters: #{
    accountID: ExampleID,
    capabilityID: CapabilityID.collectFunds,
  },
  returnType: #{ xRequestID: ExampleID, statusCode: HttpStatusNoContent },
})
@extension("x-speakeasy-name-override", "disable")
op disableCapability(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,

  @path
  capabilityID: CapabilityID,
): DisableResponses;
