import "@typespec/http";
import "./examples.refund.tsp";
import "./models.refund.tsp";
import "./models.transfer.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;

namespace MoovAPI;

@doc("""
  Initiate a refund for a card transfer.
  
  **Use the [Cancel or refund a card transfer](https://docs.moov.io/api/money-movement/refunds/cancel/) endpoint for more comprehensive cancel and refund options.**    
  See the [reversals](https://docs.moov.io/guides/money-movement/accept-payments/card-acceptance/reversals/) guide for more information. 
  
  To access this endpoint using a [token](https://docs.moov.io/api/authentication/access-tokens/) you'll need to specify the `/accounts/{accountID}/transfers.write` 
  scope.
  """)
@post
@route("/accounts/{accountID}/transfers/{transferID}/refunds")
@tag("Transfers")
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.write"]>)
@opExample(
  #{ returnType: #{ statusCode: 200, body: ExampleCreateSyncRefundSuccess } },
  #{ title: "Successful sync refund" }
)
@opExample(
  #{ returnType: #{ statusCode: 200, body: ExampleAsyncRefund } },
  #{ title: "Successful async refund" }
)
op refundTransfer(
  ...CommonHeaders,

  @doc("Prevents duplicate refunds from being created.")
  @format("uuid")
  @header
  xIdempotencyKey: string,

  @doc("""
    Optional header that indicates whether to return a synchronous response that includes full transfer and rail-specific details or an 
    asynchronous response indicating the transfer was created (this is the default response if the header is omitted).
    """)
  @header
  xWaitFor?: TransferWaitFor,

  @doc("The merchant's Moov account ID.")
  @format("uuid")
  @path
  accountID: string,

  @doc("Identifier for the transfer.")
  @format("uuid")
  @path
  transferID: string,

  @body body?: CreateRefund,
):
  | MoovAPI.OkResponse<CreateRefundResponse>
  | CreateRefundTimeoutResponse
  | MoovAPI.BadRequestResponse
  | MoovAPI.NotFoundResponse
  | DuplicateRefundResponse
  | MoovAPI.UnprocessableEntityResponse<RefundValidationError>
  | MoovAPI.RateLimitedResponse;

@doc("""
  Get a list of refunds for a card transfer.
  
  To access this endpoint using a [token](https://docs.moov.io/api/authentication/access-tokens/) you'll need to specify the `/accounts/{accountID}/transfers.read` 
  scope.
  """)
@get
@tag("Transfers")
@route("/accounts/{accountID}/transfers/{transferID}/refunds")
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.read"]>)
@opExample(#{
  returnType: #{ statusCode: 200, body: #[ExampleCardAcquiringRefund] },
})
op listRefunds(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @doc("Identifier for the transfer.")
  @format("uuid")
  @path
  transferID: string,
): ListResponses<CardAcquiringRefund>;

@doc("""
  Get details of a refund for a card transfer.
  
  To access this endpoint using a [token](https://docs.moov.io/api/authentication/access-tokens/) you'll need to specify the `/accounts/{accountID}/transfers.read` 
  scope.
  """)
@get
@tag("Transfers")
@route("/accounts/{accountID}/transfers/{transferID}/refunds/{refundID}")
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.read"]>)
@opExample(#{
  returnType: #{ statusCode: 200, body: ExampleCardAcquiringRefund },
})
op getRefund(
  ...CommonHeaders,

  @doc("Identifier for the transfer.")
  @format("uuid")
  @path
  transferID: string,

  @format("uuid")
  @path
  accountID: string,

  @doc("Identifier for the refund.")
  @format("uuid")
  @path
  refundID: string,
): GetResponses<CardAcquiringRefund>;
