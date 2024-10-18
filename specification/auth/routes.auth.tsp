import "@typespec/http";
import "./models.auth.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;

@tag("Authentication")
@route("/oauth2/token")
namespace MoovAPI.Auth {
  @doc("Use the `client_id` and `client_secret` to generate an access token.")
  @post
  @useAuth(BasicAuth)
  op createAuthToken(
    @body request: Auth.AuthTokenRequest,
  ): Common.Post<Auth.AccessToken>;
}
