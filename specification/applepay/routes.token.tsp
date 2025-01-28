import "@typespec/http";
import "@typespec/openapi";
import "./models.token.tsp";
import "../auth/models.auth.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@post
@route("/accounts/{accountID}/apple-pay/tokens")
@tag("Apple pay")
@doc("""
  Connect an Apple Pay token to the specified account. 
  
  Read our [Apple Pay tutorial](https://docs.moov.io/guides/sources/cards/apple-pay/#register-your-domains) to learn more. 
  The `token` data is defined by Apple Pay and should be passed through from Apple Pay's response unmodified.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/cards.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/cards.write"]>)
@extension("x-speakeasy-name-override", "linkToken")
op linkApplePayToken(
  ...CommonHeaders,

  @doc("ID of the Moov account representing the cardholder.")
  @format("uuid")
  @path
  accountID: string,

  @body body: LinkApplePay,
): PostResponses<LinkedApplePayPaymentMethod, LinkApplePayError>;
