import "@typespec/http";
import "@typespec/openapi";
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
using TypeSpec.OpenAPI;

namespace MoovAPI;

@get
@route("/accounts/{accountID}/wallets/{walletID}/transactions")
@tag("Wallet transactions")
@doc("""
  List all the transactions associated with a particular Moov wallet. 
  
  Read our [wallet transactions guide](https://docs.moov.io/guides/sources/wallets/transactions/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/wallets.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/wallets.read"]>)
@useAuth(BasicAuth)
@opExample(#{
  parameters: #{ accountID: ExampleID, walletID: ExampleID },
  returnType: #{
    statusCode: HttpStatusOK,
    body: #[ExampleWalletTransactionCompleted, ExampleWalletTransactionPending],
  },
})
@extension("x-speakeasy-name-override", "list")
op listWalletTransactions(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  ...ListTransactionsQuery,
): ListResponses<WalletTransaction>;

@get
@route("/accounts/{accountID}/wallets/{walletID}/transactions/{transactionID}")
@tag("Wallet transactions")
@doc("""
  Get details on a specific wallet transaction. 
  
  Read our [wallet transactions guide](https://docs.moov.io/guides/sources/wallets/transactions/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/wallets.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/wallets.read"]>)
@useAuth(BasicAuth)
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
@extension("x-speakeasy-name-override", "get")
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
