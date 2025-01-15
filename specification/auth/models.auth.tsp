import "@typespec/http";

using TypeSpec.Http;

namespace MoovAPI;

// OAuth2 flow

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

// Auth token requests/responses

@doc("A value passed to the authorization server to gain access to the system.")
@example("eyJhbGciOiJFZERTQSIsImN0eSI6IkpXVCIsImtpZCI6IkR...")
@maxLength(4096)
scalar AccessToken extends string;

@doc("A value passed to the authorization server to obtain a new access token.")
@example("eyJhbGc0eSI6TQSIsImN0kpXVCIsImtp6IkpXVsImtpZC0a...")
@maxLength(4096)
scalar RefreshToken extends string;

model AuthTokenRequest {
  grant_type: GrantType;

  @doc("Client ID can be provided here in the body, or as the Username in HTTP Basic Auth.")
  @example("5clTR_MdVrrkgxw2")
  client_id?: string;

  @doc("Client secret can be provided here in the body, or as the Password in HTTP Basic Auth.")
  @example("dNC-hg7sVm22jc3g_Eogtyu0_1Mqh_4-")
  client_secret?: string;

  @doc("A space delimited list of scopes. Required when `grant_type` is `client_credentials`.")
  @example("/accounts.read /accounts.write")
  scope?: string;

  @doc("The refresh_token returned alongside the access token being refreshed. Required when `grant_type` is `refresh_token`.")
  @example("eyJhbGc0eSI6TQSIsImN0kpXVCIsImtp6IkpXVsImtpZC0a...")
  refresh_token?: string;
}

model AuthTokenRequestError {
  scope?: string;
  refresh_token?: string;
}

model AuthToken {
  token_type: TokenType;
  access_token: AccessToken;
  refresh_token: RefreshToken;

  @doc("Unix timestamp indicating when this token expires.")
  @example(unixTimestamp32.fromISO("2025-01-15T18:05:52Z"))
  expires_in: unixTimestamp32;

  @doc("A space-delimited list of [scopes](https://docs.moov.io/api/authentication/scopes/) that are allowed.")
  @example("/accounts.read /accounts.write")
  scope: string;
}

model RevokeTokenRequest {
  @doc("The access or refresh token to revoke.")
  token: string;

  @doc("The type of token being revoked.")
  token_type_hint?: "access_token" | "refresh_token";

  @doc("Client ID can be provided here in the body, or as the Username in HTTP Basic Auth.")
  @example("5clTR_MdVrrkgxw2")
  client_id?: string;

  @doc("Client secret can be provided here in the body, or as the Password in HTTP Basic Auth.")
  @example("dNC-hg7sVm22jc3g_Eogtyu0_1Mqh_4-")
  client_secret?: string;
}

model RevokeTokenRequestError {
  token?: string;
  token_type_hint?: string;
}

@doc("""
  The type of grant being requested.
  
    - `client_credentials`: A grant type used by clients to obtain an access token
    - `refresh_token`: A grant type used by clients to obtain a new access token using a refresh token
  """)
enum GrantType {
  ClientCredentials: "client_credentials",
  RefreshToken: "refresh_token",
}

@doc("""
  Type of token returned.
  
    - `opaque`: A token following a proprietary format.
    - `jwt`: A JSON Web Token (JWT), a self-contained token that contains claims about the user and is cryptographically signed.
  """)
@example(TokenType.opaque)
enum TokenType {
  opaque,
  jwt,
}
