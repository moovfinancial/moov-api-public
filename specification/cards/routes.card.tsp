import "@typespec/http";
import "@typespec/openapi";
import "./models.card.tsp";
import "../auth/models.auth.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@post
@route("/accounts/{accountID}/cards")
@tag("Cards")
@doc("""
  Link a card to an existing Moov account. 
  
  Read our [accept card payments guide](https://docs.moov.io/guides/sources/cards/accept-card-payments/#link-a-card) to learn more.
  
  Only use this endpoint if you have provided Moov with a copy of your PCI attestation of compliance. 
  
  During card linking, the provided data will be verified by submitting a $0 authorization (account verification) request. 
  If `merchantAccountID` is provided, the authorization request will contain that account's statement descriptor and address. 
  Otherwise, the platform account's profile will be used. If no statement descriptor has been set, the authorization will 
  use the account's name instead.
  
  It is strongly recommended that callers include the `X-Wait-For` header, set to `payment-method`, if the newly linked 
  card is intended to be used right away. If this header is not included, the caller will need to poll the [List Payment 
  Methods](https://docs.moov.io/api/sources/payment-methods/list/)
  endpoint to wait for the new payment methods to be available for use.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/cards.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/cards.write"]>)
@useAuth(BasicAuth)
@extension("x-speakeasy-name-override", "link")
op linkCard(
  ...CommonHeaders,

  @doc("""
    Optional header to wait for certain events, such as the creation of a payment method, to occur before returning a response.
    
    When this header is set to `payment-method`, the response will include any payment methods that were created for the newly 
    linked card in the `paymentMethods` field. Otherwise, the `paymentMethods` field will be omitted from the response.
    """)
  @example(LinkCardWaitFor.paymentMethod)
  @header
  xWaitFor?: LinkCardWaitFor,

  @format("uuid")
  @path
  accountID: string,

  @body body: LinkCard,
): PostResponses<Card, LinkCardError>;

@get
@route("/accounts/{accountID}/cards")
@tag("Cards")
@doc("""
  List all the active cards associated with a Moov account. 
  
  Read our [accept card payments guide](https://docs.moov.io/guides/sources/cards/accept-card-payments/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/cards.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/cards.read"]>)
@useAuth(BasicAuth)
@extension("x-speakeasy-name-override", "list")
op listCards(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,
): ListResponses<Card>;

@get
@route("/accounts/{accountID}/cards/{cardID}")
@tag("Cards")
@doc("""
  Fetch a specific card associated with a Moov account. 
  
  Read our [accept card payments guide](https://docs.moov.io/guides/sources/cards/accept-card-payments/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/cards.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/cards.read"]>)
@useAuth(BasicAuth)
@extension("x-speakeasy-name-override", "get")
op getCard(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @path
  cardID: CardID,
): GetResponses<Card>;

@patch
@route("/accounts/{accountID}/cards/{cardID}")
@tag("Cards")
@doc("""
  Update a linked card and/or resubmit it for verification. 
  
  If a value is provided for CVV, a new verification ($0 authorization) will be submitted for the card. Updating the expiration 
  date or 
  address will update the information stored on file for the card but will not be verified.
  
  Read our [accept card payments guide](https://docs.moov.io/guides/sources/cards/accept-card-payments/#reverify-a-card) to learn 
  more.
  
  Only use this endpoint if you have provided Moov with a copy of your PCI attestation of compliance. 
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/cards.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/cards.write"]>)
@useAuth(BasicAuth)
@extension("x-speakeasy-name-override", "update")
op updateCard(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @path
  cardID: CardID,

  @body body: UpdateCard,
): UpdateResponses<Card, UpdateCardError>;

@delete
@route("/accounts/{accountID}/cards/{cardID}")
@tag("Cards")
@doc("""
  Disables a card associated with a Moov account.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/cards.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/cards.write"]>)
@useAuth(BasicAuth)
@extension("x-speakeasy-name-override", "disable")
op disableCard(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @path
  cardID: CardID,
): DisableResponses;
