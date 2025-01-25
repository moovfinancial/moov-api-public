import "@typespec/http";
import "@typespec/openapi";
import "./models.sweep.tsp";
import "./examples.sweep.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

// List

@get
@route("/accounts/{accountID}/wallets/{walletID}/sweeps")
@tag("Sweeps")
@doc("""
  List sweeps associated with a wallet.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/wallets.read` scope.
  """)
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/wallets.read"]>)
@opExample(#{
  parameters: #{ accountID: ExampleID, walletID: ExampleID },
  returnType: #{ statusCode: HttpStatusOK, body: #[ExampleSweep] },
})
@extension("x-speakeasy-name-override", "list")
op listSweeps(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @path
  walletID: WalletID,

  ...Pagination,

  @doc("""
    Optional parameter to filter by sweep status.
    """)
  @query
  status?: SweepStatus,

  @doc("""
    Optional string to filter by statement descriptor.
    """)
  @query
  statementDescriptor?: SweepStatementDescriptor,
): ListResponses<Sweep>;

// Get

@get
@route("/accounts/{accountID}/wallets/{walletID}/sweeps/{sweepID}")
@tag("Sweeps")
@doc("""
  Get details on a specific sweep.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/wallets.read` scope.
  """)
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/wallets.read"]>)
@opExample(#{
  parameters: #{
    accountID: ExampleID,
    walletID: ExampleID,
    sweepID: ExampleID,
  },
  returnType: #{ statusCode: HttpStatusOK, body: ExampleSweep },
})
@extension("x-speakeasy-name-override", "get")
op getSweep(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @path
  walletID: WalletID,

  @path
  sweepID: SweepID,
): GetResponses<Sweep>;
