import "@typespec/http";
import "./models.auth.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;

namespace MoovAPI {
  @doc("Use the `client_id` and `client_secret` to generate an access token.")
  @post
  @useAuth(BasicAuth)
  @tag("Authentication")
  @route("/oauth2/token")
  op createAuthToken(@body request: AuthTokenRequest): PostResponses<
    AccessToken,
    unknown
  >;
}
