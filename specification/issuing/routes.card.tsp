import "@typespec/http";
import "@typespec/openapi";
import "./models.card.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@post
@route("/issuing/{accountID}/issued-cards")
@tag("Card issuing")
@doc("""
  Request a virtual card be issued.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/issued-cards.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/issued-cards.write"]>)
@extension("x-speakeasy-name-override", "request")
op requestCard(
  ...CommonHeaders,

  @doc("The Moov business account for which the card is to be issued.")
  @format("uuid")
  @path
  accountID: string,

  @body body: RequestCard,
):
  | OkResponse<IssuedCard>
  | BadRequestResponse
  | UnauthorizedResponse
  | ForbiddenResponse
  | NotFoundResponse
  | UnprocessableEntityResponse<RequestCardError>
  | RateLimitedResponse
  | InternalServerErrorResponse
  | GatewayTimeoutResponse;

@get
@route("/issuing/{accountID}/issued-cards")
@tag("Card issuing")
@doc("""
  List Moov issued cards existing for the account.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/issued-cards.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/issued-cards.read"]>)
@extension("x-speakeasy-name-override", "list")
op listIssuedCards(
  ...CommonHeaders,

  @doc("The Moov business account for which the cards have been issued.")
  @format("uuid")
  @path
  accountID: string,

  ...Pagination,

  @doc("Optional, comma-separated states to filter the Moov list issued cards response. For example `active,pending-verification`")
  @query
  states?: IssuedCardState[],
): ListResponses<IssuedCard>;

@get
@route("/issuing/{accountID}/issued-cards/{issuedCardID}")
@tag("Card issuing")
@doc("""
  Retrieve a single issued card associated with a Moov account.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/issued-cards.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/issued-cards.read"]>)
@extension("x-speakeasy-name-override", "get")
op getIssuedCard(
  ...CommonHeaders,

  @doc("The Moov business account for which the card was issued.")
  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  issuedCardID: string,
): GetResponses<IssuedCard>;

@patch
@route("/issuing/{accountID}/issued-cards/{issuedCardID}")
@tag("Card issuing")
@doc("""
  Update a Moov issued card.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/issued-cards.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/issued-cards.write"]>)
@extension("x-speakeasy-name-override", "update")
op updateIssuedCard(
  ...CommonHeaders,

  @doc("The Moov business account for which the card was issued.")
  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  issuedCardID: string,

  @body body: UpdateIssuedCard,
): UpdateNoContentResponses<UpdateIssuedCardError>;

@get
@route("/issuing/{accountID}/issued-cards/{issuedCardID}/details")
@tag("Card issuing")
@doc("""
  Get issued card with PAN, CVV, and expiration. 
  
  Only use this endpoint if you have provided Moov with a copy of your PCI attestation of compliance.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/issued-cards.read-secure` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/issued-cards.read-secure"]>)
@extension("x-speakeasy-name-override", "getFull")
op getFullIssuedCard(
  ...CommonHeaders,

  @doc("The Moov business account for which the card was issued.")
  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  issuedCardID: string,
): GetResponses<FullIssuedCard>;
