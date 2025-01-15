import "@typespec/http";
import "./models.end2end.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.jwk.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;

namespace MoovAPI;

@post
@route("/end-to-end-keys")
@tag("End to End Encryption")
@doc("""
  Generates a public key used to create a JWE token for passing secure authentication data through non-PCI compliant intermediaries.
  """)
op generateEndToEndKey(
  ...CommonHeaders,
): OkResponse<JSONWebKey> | RateLimitedResponse;

@post
@route("/debug/end-to-end-token")
@tag("End to End Encryption")
@doc("""
  Allows for testing a JWE token to ensure it's acceptable by Moov. 
  
  To access this endpoint using a [token](https://docs.moov.io/api/authentication/access-tokens/) you'll need 
  to specify the `/ping.read` scope.
  """)
@useAuth(BasicAuth | OAuth2<["/ping.read"]>)
op testEndToEndToken(
  ...CommonHeaders,
  @body body: E2EEToken,
): NoContentResponse | BadRequestResponse | RateLimitedResponse;
