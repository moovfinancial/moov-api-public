import "@typespec/http";
import "@typespec/openapi";
import "./models.authorization.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@get
@route("/issuing/{accountID}/authorizations")
@tag("Issuing transactions")
@doc("""
  List issued card authorizations associated with a Moov account.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/issued-cards.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/issued-cards.read"]>)
@extension("x-speakeasy-name-override", "listAuthorizations")
op listIssuedCardAuthorizations(
  ...CommonHeaders,

  @doc("The Moov business account for which cards have been issued.")
  @format("uuid")
  @path
  accountID: string,

  ...ListIssuingAuthorizationsQuery,
): ListResponses<IssuedCardAuthorization>;

@get
@route("/issuing/{accountID}/authorizations/{authorizationID}")
@tag("Issuing transactions")
@doc("""
  Retrieves details of an authorization associated with a specific Moov account.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/issued-cards.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/issued-cards.read"]>)
@extension("x-speakeasy-name-override", "getAuthorization")
op getIssuedCardAuthorization(
  ...CommonHeaders,

  @doc("The Moov business account for which cards have been issued.")
  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  authorizationID: string,
): GetResponses<IssuedCardAuthorization>;

@get
@route("/issuing/{accountID}/authorizations/{authorizationID}/events")
@tag("Issuing transactions")
@doc("""
  List card network and Moov platform events that affect the authorization and its hold on a wallet balance.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/issued-cards.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/issued-cards.read"]>)
@extension("x-speakeasy-name-override", "listAuthorizationEvents")
op listIssuedCardAuthorizationEvents(
  ...CommonHeaders,

  @doc("The Moov business account for which cards have been issued.")
  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  authorizationID: string,

  ...Pagination,
): ListResponses<IssuedCardAuthorizationEvent>;
