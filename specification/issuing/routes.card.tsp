import "@typespec/http";
import "./models.card.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;

namespace MoovAPI;

@post
@route("/issuing/{accountID}/issued-cards")
@tag("Card issuing")
@doc("""
  Request a virtual card be issued.
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/issued-cards.write` scope when generating 
  a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/issued-cards.write"]>)
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
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/issued-cards.read` scope when generating 
  a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/issued-cards.read"]>)
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
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/issued-cards.read` scope when generating 
  a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/issued-cards.read"]>)
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
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/issued-cards.write` scope when generating 
  a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/issued-cards.write"]>)
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
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/issued-cards.read-secure` scope when generating 
  a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/issued-cards.read-secure"]>)
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
