import "@typespec/http";
import "./examples.capability.tsp";
import "./models.capability.tsp";
import "../auth/models.auth.tsp";
import "../common/examples.id.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";

using TypeSpec.Http;

namespace MoovAPI;

// List

@doc("""
  Retrieve all the capabilities an account has requested.
  
  Read our [capabilities guide](https://docs.moov.io/guides/accounts/capabilities/) to learn more.
  """)
@tag("Capabilities")
@route("/accounts/{accountID}/capabilities")
@get
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/capabilities.read"]>)
@opExample(#{
  parameters: #{ accountID: ExampleID },
  returnType: #{
    statusCode: HttpStatusOK,
    body: #[ExampleTransfersCapability, ExampleCollectFundsCapability],
  },
})
op listCapabilities(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,
): ListResponses<Capability>;

// Add

@doc("""
  Request capabilities for a specific account. Read our [capabilities guide](https://docs.moov.io/guides/accounts/capabilities/) to learn more.
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/capabilities.write` scope when generating a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@tag("Capabilities")
@route("/accounts/{accountID}/capabilities")
@post
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/capabilities.write"]>)
@opExample(#{
  parameters: #{
    accountID: ExampleID,
    body: #{ capabilities: #[CapabilityID.collectFunds] },
  },
  returnType: #{
    statusCode: HttpStatusOK,
    body: #[ExampleTransfersCapability, ExampleCollectFundsCapability],
  },
})
op addCapabilities(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @body body: AddCapabilities,
): PostResponses<Capability[], AddCapabilitiesError>;

// Get

@doc("""
  Retrieve a specific capability that an account has requested. Read our [capabilities guide](https://docs.moov.io/guides/accounts/capabilities/) to learn more.
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/capabilities.read` scope when generating a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@tag("Capabilities")
@route("/accounts/{accountID}/capabilities/{capabilityID}")
@get
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/capabilities.read"]>)
@opExample(#{
  parameters: #{ accountID: ExampleID, capabilityID: CapabilityID.transfers },
  returnType: #{ statusCode: HttpStatusOK, body: ExampleTransfersCapability },
})
op getCapability(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @path
  capabilityID: CapabilityID,
): GetResponses<Capability>;

// Disable

@doc("""
  Disable a specific capability that an account has requested. Read our [capabilities guide](https://docs.moov.io/guides/accounts/capabilities/) to learn more.
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/capabilities.write` scope when generating a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@tag("Capabilities")
@route("/accounts/{accountID}/capabilities/{capabilityID}")
@delete
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/capabilities.write"]>)
@opExample(#{
  parameters: #{
    accountID: ExampleID,
    capabilityID: CapabilityID.collectFunds,
  },
  returnType: #{ statusCode: HttpStatusNoContent },
})
op disableCapability(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @path
  capabilityID: CapabilityID,
): DisableResponses;
