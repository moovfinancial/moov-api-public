import "@typespec/http";
import "@typespec/openapi";
import "./models.session.tsp";
import "../auth/models.auth.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@post
@route("/accounts/{accountID}/apple-pay/sessions")
@tag("Apple pay")
@doc("""
  Create a session with Apple Pay to facilitate a payment. 
  
  Read our [Apple Pay tutorial](https://docs.moov.io/guides/sources/cards/apple-pay/#register-your-domains) to learn more. 
  A successful response from this endpoint should be passed through to Apple Pay unchanged. 
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/apple-pay.write` scope.
  """)
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/apple-pay.write"]>)
@extension("x-speakeasy-name-override", "createSession")
op createApplePaySession(
  ...CommonHeaders,

  @doc("ID of the Moov account representing the merchant.")
  @format("uuid")
  @path
  accountID: string,

  @body body: CreateApplePaySession,
): PostResponses<ApplePaySession, GenericError>;
