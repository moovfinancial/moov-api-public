import "@typespec/http";
import "./examples.transaction.tsp";
import "./models.sweep.tsp";
import "./models.transaction.tsp";
import "./models.wallet.tsp";
import "../auth/models.auth.tsp";
import "../common/examples.id.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";

using TypeSpec.Http;

namespace MoovAPI;

// List

@doc("""
  List all the transactions associated with a particular Moov wallet. Read our [wallet transactions guide](https://docs.moov.io/guides/sources/wallets/transactions/) to learn more.
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/wallets.read` scope when generating a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@tag("Wallet transactions")
@route("/accounts/{accountID}/wallets/{walletID}/transactions")
@get
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/wallets.read"]>)
@opExample(#{
  parameters: #{ accountID: ExampleID, walletID: ExampleID },
  returnType: #{
    statusCode: HttpStatusOK,
    body: #[ExampleWalletTransactionCompleted, ExampleWalletTransactionPending],
  },
})
op listWalletTransactions(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @path
  walletID: WalletID,

  ...Pagination,

  @doc("""
    Optional parameter to filter by transaction type.
    """)
  @query
  transactionType?: WalletTransactionType,

  @doc("""
    Optional parameter to filter by source type (i.e. transfer, dispute, issuing-transaction).
    """)
  @query
  sourceType?: WalletTransactionSourceType,

  @doc("""
    Optional parameter to filter by source ID.
    """)
  @format("uuid")
  @query
  sourceID?: string,

  @doc("""
    Optional parameter to filter by status (`pending` or `completed`).
    """)
  @query
  status?: WalletTransactionStatus,

  @doc("""
    Optional date-time which inclusively filters all transactions created after this date-time.  
    """)
  @query
  createdStartDateTime?: utcDateTime,

  @doc("""
    Optional date-time which exclusively filters all transactions created before this date-time.
    """)
  @query
  createdEndDateTime?: utcDateTime,

  @doc("""
    Optional date-time which inclusively filters all transactions completed after this date-time.
    """)
  @query
  completedStartDateTime?: utcDateTime,

  @doc("""
    Optional date-time which exclusively filters all transactions completed before this date-time.
    """)
  @query
  completedEndDateTime?: utcDateTime,

  @doc("""
    Optional ID to filter for transactions accrued in a sweep.
    """)
  @query
  sweepID?: SweepID,
): ListResponses<WalletTransaction>;

// Get

@doc("""
  Get details on a specific wallet transaction. Read our [wallet transactions guide](https://docs.moov.io/guides/sources/wallets/transactions/) to learn more.
  
  To use this endpoint from a browser, you'll need to specify the `/accounts/{accountID}/wallets.read` scope when generating a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@tag("Wallet transactions")
@route("/accounts/{accountID}/wallets/{walletID}/transactions/{transactionID}")
@get
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/wallets.read"]>)
@opExample(#{
  parameters: #{
    accountID: ExampleID,
    walletID: ExampleID,
    transactionID: ExampleID,
  },
  returnType: #{
    statusCode: HttpStatusOK,
    body: ExampleWalletTransactionCompleted,
  },
})
op getWalletTransaction(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @path
  walletID: WalletID,

  @path
  transactionID: WalletTransactionID,
): GetResponses<WalletTransaction>;
