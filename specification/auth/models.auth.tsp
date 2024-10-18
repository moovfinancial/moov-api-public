import "@typespec/http";

using TypeSpec.Http;

namespace MoovAPI.Auth;

alias OAuth2<Scopes extends string[]> = OAuth2Auth<
  [
    {
      type: OAuth2FlowType.authorizationCode;
      authorizationUrl: "/oauth2/authorize";
      tokenUrl: "/oauth2/token";
      refreshUrl: "/oauth2/token";
    }
  ],
  Scopes = Scopes
>;

model AuthTokenRequest {
  grant_type: GrantType;

  @doc("A space delimited list of scopes")
  @example("/moov/support.read /moov/support.write")
  scopes: string;
}

@doc("The type of grant being requested.")
enum GrantType {
  ClientCredentials: "client_credentials",
  RefreshToken: "refresh_token",
}

model AccessToken {
  @doc("String passed to the authorization server to gain access to the system.")
  @example("i1qxz68gu50zp4i8ceyxqogmq7y0yienm52351c6...")
  access_token: string;

  @doc("Number of seconds for which the token is valid.")
  @example(900)
  expires_in: int32;

  @doc("String passed to the authorization server to gain access to the system.")
  @example("i1qxz68gu50zp4i8ceyxqogmq7y0yienm52351c6...")
  refresh_token: string;

  @doc("A space-delimited list of [scopes](https://docs.moov.io/api/authentication/scopes/) that are allowed.")
  @example("/accounts.write")
  scope: string;

  token_type: TokenType;
}

@doc("Type of token returned.")
@example(TokenType.Opaque)
enum TokenType {
  @doc("A token following a proprietary format.")
  Opaque: "opaque",

  @doc("A JSON Web Token (JWT), a self-contained token that contains claims about the user and is cryptographically signed.")
  JWT: "jwt",
}
