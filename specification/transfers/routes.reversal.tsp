import "@typespec/http";
import "./examples.reversal.tsp";
import "./models.reversal.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;

namespace MoovAPI;

@post
@route("/accounts/{accountID}/transfers/{transferID}/reversals")
@tag("Transfers")
@doc("""
  Reverses a card transfer by initiating a cancellation or refund depending on the transaction status. 
  Read our [reversals guide](https://docs.moov.io/guides/money-movement/accept-payments/card-acceptance/reversals/) 
  to learn more.
  
  To access this endpoint using a [token](https://docs.moov.io/api/authentication/access-tokens/) you'll need 
  to specify the `/accounts/{accountID}/transfers.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.write"]>)
@opExample(ExampleReversalCancellation, #{ title: "Reversed by cancellation" })
@opExample(ExampleReversalRefund, #{ title: "Reversed by refund" })
op createReversal(
  ...CommonHeaders,

  @doc("Prevents duplicate reversals from being created.")
  @format("uuid")
  @header
  xIdempotencyKey: string,

  @doc("The Moov account ID.")
  @format("uuid")
  @path
  accountID: string,

  @doc("The transfer ID to reverse.")
  @format("uuid")
  @path
  transferID: string,

  @body body?: CreateReversal,
):
  | CreatedReversalResponse
  | CreatedReversalAsyncResponse
  | BadRequestResponse
  | UnauthorizedResponse
  | ForbiddenResponse
  | NotFoundResponse
  | StateConflictResponse
  | UnprocessableEntityResponse<ReversalValidationError>
  | RateLimitedResponse
  | InternalServerErrorResponse
  | GatewayTimeoutResponse;
