import "@typespec/http";
import "./models.transaction.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;

namespace MoovAPI;

@get
@route("/issuing/{accountID}/card-transactions")
@tag("Issuing transactions")
@doc("""
  List issued card transactions associated with a Moov account.
  
  To access this endpoint using a [token](https://docs.moov.io/api/authentication/access-tokens/) you'll need to specify 
  the `/accounts/{accountID}/issued-cards.read` scope.
  """)
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/issued-cards.read"]>)
op listIssuedCardTransactions(
  ...CommonHeaders,

  @doc("The Moov business account for which cards have been issued.")
  @format("uuid")
  @path
  accountID: string,

  ...ListIssuingTransactionsQuery,
): ListResponses<IssuedCardTransaction>;

@get
@route("/issuing/{accountID}/card-transactions/{cardTransactionID}")
@tag("Issuing transactions")
@doc("""
  Retrieves details of an issued card transaction associated with a specific Moov account.
  
  To access this endpoint using a [token](https://docs.moov.io/api/authentication/access-tokens/) you'll need to specify 
  the `/accounts/{accountID}/issued-cards.read` scope.
  """)
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/issued-cards.read"]>)
op getIssuedCardTransaction(
  ...CommonHeaders,

  @doc("The Moov business account for which cards have been issued.")
  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  cardTransactionID: string,
): GetResponses<IssuedCardTransaction>;
