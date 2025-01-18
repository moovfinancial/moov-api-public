import "@typespec/http";
import "./models.ping.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;

namespace MoovAPI;

@get
@route("/ping")
@tag("Ping")
@doc("""
  A simple endpoint to check auth.
  
  To access this endpoint using a [token](https://docs.moov.io/api/authentication/access-tokens/) you'll need 
  to specify the `/ping.read` scope.
  """)
@useAuth(BasicAuth | OAuth2<["/ping.read"]>)
op ping(...CommonHeaders):
  | SuccessfulPingResponse
  | UnauthorizedResponse
  | ForbiddenResponse
  | NotFoundResponse
  | RateLimitedResponse
  | InternalServerErrorResponse;
