import "@typespec/http";
import "./examples.wallet.tsp";
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
  List the wallets associated with a Moov account. Read our [Moov wallets guide](https://docs.moov.io/guides/sources/wallets/) to learn more.
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/wallets.read` scope when generating a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@tag("Wallets")
@route("/accounts/{accountID}/wallets")
@get
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/wallets.read"]>)
@opExample(#{
  parameters: #{ accountID: ExampleID },
  returnType: #{ statusCode: HttpStatusOK, body: #[ExampleWallet] },
})
op listWallets(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,
): ListResponses<Wallet>;

// Get

@doc("""
  Get information on a specific wallet (e.g., the available balance). Read our [Moov wallets guide](https://docs.moov.io/guides/sources/wallets/) to learn more.
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/wallets.read` scope when generating a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@tag("Wallets")
@route("/accounts/{accountID}/wallets/{walletID}")
@get
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/wallets.read"]>)
@opExample(#{
  parameters: #{ accountID: ExampleID, walletID: ExampleID },
  returnType: #{ statusCode: HttpStatusOK, body: ExampleWallet },
})
op getWallet(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @path
  walletID: WalletID,
): GetResponses<Wallet>;
