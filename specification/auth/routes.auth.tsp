import "@typespec/http";
import "./models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;

namespace MoovAPI;

@post
@route("/oauth2/token")
@tag("Authentication")
@doc("""
  Create or refresh an access token.
  """)
@useAuth(BasicAuth)
op createAccessToken(
  ...CommonHeaders,
  @header contentType: "application/json" | "application/x-www-form-urlencoded",
  @body request: AuthTokenRequest,
):
  | OkResponse<AuthToken>
  | BadRequestResponse
  | UnprocessableEntityResponse<AuthTokenRequestError>
  | RateLimitedResponse
  | InternalServerErrorResponse
  | GatewayTimeoutResponse;

@post
@route("/oauth2/revoke")
@tag("Authentication")
@doc("""
  Revoke an auth token.
  
  Allows clients to notify the authorization server that a previously obtained refresh or access token is no longer needed.
  """)
@useAuth(BasicAuth)
op revokeAccessToken(
  ...CommonHeaders,
  @header contentType: "application/json" | "application/x-www-form-urlencoded",
  @body request: RevokeTokenRequest,
):
  | NoContentResponse
  | BadRequestResponse
  | UnprocessableEntityResponse<RevokeTokenRequestError>
  | RateLimitedResponse
  | InternalServerErrorResponse
  | GatewayTimeoutResponse;
