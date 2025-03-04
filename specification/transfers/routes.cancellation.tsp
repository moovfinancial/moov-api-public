import "@typespec/http";
import "./examples.cancellation.tsp";
import "./models.cancellation.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;

namespace MoovAPI;

@post
@route("/accounts/{accountID}/transfers/{transferID}/cancellations")
@tag("Transfers")
@doc("""
    Initiate a cancellation for a card, ACH, or queued transfer.
    
    To access this endpoint using a [token](https://docs.moov.io/api/authentication/access-tokens/) you'll need 
    to specify the `/accounts/{accountID}/transfers.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.write"]>)
@opExample(ExampleCreateCancellation, #{ title: "Created cancellation" })
op createCancellation(
  ...CommonRequestHeaders,

  @doc("The partner's Moov account ID.")
  @format("uuid")
  @path
  accountID: string,

  @doc("The transfer ID to cancel.")
  @format("uuid")
  @path
  transferID: string,
):
  | OkResponse<Cancellation>
  | CreatedCancellationAsyncResponse
  | BadRequestResponse
  | UnauthorizedResponse
  | ForbiddenResponse
  | NotFoundResponse
  | RateLimitedResponse
  | InternalServerErrorResponse
  | GatewayTimeoutResponse;

@get
@route("/accounts/{accountID}/transfers/{transferID}/cancellations/{cancellationID}")
@tag("Transfers")
@doc("""
    Get details of a cancellation for a transfer.
    
    To access this endpoint using a [token](https://docs.moov.io/api/authentication/access-tokens/) you'll need 
    to specify the `/accounts/{accountID}/transfers.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.read"]>)
@opExample(ExampleCreateCancellation, #{ title: "Got cancellation" })
op getCancellation(
  ...CommonRequestHeaders,

  @doc("Moov account ID of the partner or transfer's source or destination.")
  @format("uuid")
  @path
  accountID: string,

  @doc("Identifier for the transfer.")
  @format("uuid")
  @path
  transferID: string,

  @doc("Identifier for the cancellation.")
  @format("uuid")
  @path
  cancellationID: string,
): GetResponses<Cancellation>;
