import "@typespec/http";
import "./models.token.tsp";
import "../auth/models.auth.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";

using TypeSpec.Http;

namespace MoovAPI;

@doc("""
  Connect an Apple Pay token to the specified account. 
  
  Read our [Apple Pay tutorial](https://docs.moov.io/guides/sources/cards/apple-pay/#register-your-domains) to learn more. 
  The `token` data is defined by Apple Pay and should be passed through from Apple Pay's response unmodified.
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/cards.write` scope when generating 
  a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@tag("Cards")
@route("/accounts/{accountID}/apple-pay/tokens")
@post
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/cards.write"]>)
op linkApplePayToken(
  ...CommonHeaders,

  @doc("ID of the Moov account representing the cardholder.")
  @format("uuid")
  @path
  accountID: string,

  @body body: LinkApplePay,
): PostResponses<LinkedApplePayPaymentMethod, LinkApplePayError>;
