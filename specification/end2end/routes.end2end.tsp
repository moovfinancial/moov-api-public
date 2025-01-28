import "@typespec/http";
import "@typespec/openapi";
import "./models.end2end.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.jwk.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@post
@route("/end-to-end-keys")
@tag("End to End Encryption")
@doc("""
  Generates a public key used to create a JWE token for passing secure authentication data through non-PCI compliant intermediaries.
  """)
@extension("x-speakeasy-name-override", "generateKey")
op generateEndToEndKey(
  ...CommonHeaders,
): OkResponse<JSONWebKey> | RateLimitedResponse;

@post
@route("/debug/end-to-end-token")
@tag("End to End Encryption")
@doc("""
  Allows for testing a JWE token to ensure it's acceptable by Moov. 
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/ping.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/ping.read"]>)
@extension("x-speakeasy-name-override", "testEncryptedToken")
op testEndToEndToken(...CommonHeaders, @body body: E2EEToken):
  | NoContentResponse
  | BadRequestResponse
  | RateLimitedResponse
  | InternalServerErrorResponse
  | GatewayTimeoutResponse;
