import "@typespec/http";
import "./models.session.tsp";
import "../auth/models.auth.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";

using TypeSpec.Http;

namespace MoovAPI;

@doc("""
  Create a session with Apple Pay to facilitate a payment. 
  
  Read our [Apple Pay tutorial](https://docs.moov.io/guides/sources/cards/apple-pay/#register-your-domains) to learn more. 
  A successful response from this endpoint should be passed through to Apple Pay unchanged. 
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/apple-pay.write` scope when generating 
  a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@tag("Cards")
@route("/accounts/{accountID}/apple-pay/sessions")
@post
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/apple-pay.write"]>)
op createApplePaySession(
  ...CommonHeaders,

  @doc("ID of the Moov account representing the merchant.")
  @format("uuid")
  @path
  accountID: string,

  @body body: CreateApplePaySession,
): PostResponses<ApplePaySession, GenericError>;
