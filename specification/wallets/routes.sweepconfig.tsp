import "@typespec/http";
import "@typespec/openapi";
import "./models.sweepconfig.tsp";
import "./examples.sweepconfig.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@post
@route("/accounts/{accountID}/sweep-configs")
@tag("Sweeps")
@doc("""
  Create a sweep config for a wallet.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/wallets.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/wallets.write"]>)
@useAuth(BasicAuth)
@opExample(#{
  parameters: #{
    accountID: ExampleID,
    body: #{
      walletID: ExampleID,
      status: SweepConfigStatus.enabled,
      pushPaymentMethodID: ExampleID,
      pullPaymentMethodID: ExampleID,
    },
  },
  returnType: #{ statusCode: HttpStatusOK, body: ExampleEnabledSweepConfig },
})
@extension("x-speakeasy-name-override", "createConfig")
op createSweepConfig(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @body body: CreateSweepConfig,
): PostResponses<SweepConfig, CreateSweepConfigError>;

@get
@route("/accounts/{accountID}/sweep-configs")
@tag("Sweeps")
@doc("""
  List sweep configs associated with an account.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/wallets.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/wallets.read"]>)
@useAuth(BasicAuth)
@opExample(#{
  parameters: #{ accountID: ExampleID },
  returnType: #{
    statusCode: HttpStatusOK,
    body: #[ExampleEnabledSweepConfig, ExampleDisabledSweepConfig],
  },
})
@extension("x-speakeasy-name-override", "listConfigs")
op listSweepConfigs(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,
): ListResponses<SweepConfig>;

@get
@route("/accounts/{accountID}/sweep-configs/{sweepConfigID}")
@tag("Sweeps")
@doc("""
  Get a sweep config associated with a wallet.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/wallets.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/wallets.read"]>)
@useAuth(BasicAuth)
@opExample(#{
  parameters: #{ accountID: ExampleID, sweepConfigID: ExampleID },
  returnType: #{ statusCode: HttpStatusOK, body: ExampleEnabledSweepConfig },
})
@extension("x-speakeasy-name-override", "getConfig")
op getSweepConfig(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @path
  sweepConfigID: SweepConfigID,
): GetResponses<SweepConfig>;

@patch
@route("/accounts/{accountID}/sweep-configs/{sweepConfigID}")
@tag("Sweeps")
@doc("""
  Update settings on a sweep config.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/wallets.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/wallets.write"]>)
@useAuth(BasicAuth)
@opExample(#{
  parameters: #{
    accountID: ExampleID,
    sweepConfigID: ExampleID,
    body: #{ status: SweepConfigStatus.disabled },
  },
  returnType: #{ statusCode: HttpStatusOK, body: ExampleDisabledSweepConfig },
})
@extension("x-speakeasy-name-override", "updateConfig")
op updateSweepConfig(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @path
  sweepConfigID: SweepConfigID,

  @body body: PatchSweepConfig,
): UpdateResponses<SweepConfig, PatchSweepConfigError>;
