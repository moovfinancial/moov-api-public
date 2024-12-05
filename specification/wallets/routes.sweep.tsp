import "@typespec/http";
import "./models.sweep.tsp";
import "./examples.sweep.tsp";

using TypeSpec.Http;

namespace MoovAPI;

// List

@doc("""
  List sweeps associated with a wallet.
  """)
@tag("Sweeps")
@route("/accounts/{accountID}/wallets/{walletID}/sweeps")
@get
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/wallets.read"]>)
@opExample(#{
  parameters: #{ accountID: ExampleID, walletID: ExampleID },
  returnType: #{ statusCode: HttpStatusOK, body: #[ExampleSweep] },
})
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

@doc("""
  Get details on a specific sweep.
  """)
@tag("Sweeps")
@route("/accounts/{accountID}/wallets/{walletID}/sweeps/{sweepID}")
@get
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/wallets.read"]>)
@opExample(#{
  parameters: #{
    accountID: ExampleID,
    walletID: ExampleID,
    sweepID: ExampleID,
  },
  returnType: #{ statusCode: HttpStatusOK, body: ExampleSweep },
})
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
