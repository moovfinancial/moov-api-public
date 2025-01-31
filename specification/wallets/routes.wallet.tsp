import "@typespec/http";
import "@typespec/openapi";
import "./examples.wallet.tsp";
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
@route("/accounts/{accountID}/wallets")
@tag("Wallets")
@doc("""
  List the wallets associated with a Moov account. 
  
  Read our [Moov wallets guide](https://docs.moov.io/guides/sources/wallets/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/wallets.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/wallets.read"]>)
@opExample(#{
  parameters: #{ accountID: ExampleID },
  returnType: #{
    xRequestID: ExampleID,
    statusCode: HttpStatusOK,
    body: #[ExampleWallet],
  },
})
@extension("x-speakeasy-name-override", "list")
op listWallets(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,
): ListResponses<Wallet>;

@get
@route("/accounts/{accountID}/wallets/{walletID}")
@tag("Wallets")
@doc("""
  Get information on a specific wallet (e.g., the available balance). 
  
  Read our [Moov wallets guide](https://docs.moov.io/guides/sources/wallets/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/wallets.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/wallets.read"]>)
@opExample(#{
  parameters: #{ accountID: ExampleID, walletID: ExampleID },
  returnType: #{
    xRequestID: ExampleID,
    statusCode: HttpStatusOK,
    body: ExampleWallet,
  },
})
@extension("x-speakeasy-name-override", "get")
op getWallet(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,

  @path
  walletID: WalletID,
): GetResponses<Wallet>;
