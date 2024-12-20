import "@typespec/http";
import "./models.transfer.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;

// TODO: refactor TransfersBff2 responses to use the standardized response codes and bodies from go-http.
namespace MoovAPI;

@doc("""
  Move money by providing the source, destination, and amount in the request body.
  
  Read our [transfers overview guide](https://docs.moov.io/guides/money-movement/overview/) to learn more. 
  
  To access this endpoint using a [token](https://docs.moov.io/api/authentication/access-tokens/) you'll need to specify the `/accounts/{accountID}/transfers.write` 
  scope.
  """)
@post
@route("/accounts/{accountID}/transfers")
@tag("Transfers")
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.write"]>)
op createTransfer(
  ...CommonHeaders,

  @doc("Prevents duplicate transfers from being created.")
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

  @body body: CreateTransfer,
):
  | MoovAPI.OkResponse<Transfer | AsyncTransfer>
  | CreatedTransferSyncErrorResponse
  | CreateTransferTimeoutResponse
  | MoovAPI.BadRequestResponse
  | MoovAPI.NotFoundResponse
  | DuplicateTransferResponse
  | MoovAPI.UnprocessableEntityResponse<TransferValidationError>
  | MoovAPI.RateLimitedResponse;

@doc("""
  List all the transfers associated with a particular Moov account. 
  
  Read our [transfers overview guide](https://docs.moov.io/guides/money-movement/overview/) to learn more. 
  
  When you run this request, you retrieve 200 transfers at a time. You can advance past a results set of 200 transfers by using the `skip` parameter (for example, 
  if you set `skip`= 10, you will see a results set of 200 transfers after the first 2000). If you are searching a high volume of transfers, the request will likely 
  process very slowly. To achieve faster performance, restrict the data as much as you can by using the `StartDateTime` and `EndDateTime` parameters for a limited 
  period of time. You can run multiple requests in smaller time window increments until you've retrieved all the transfers you need.
  
  To access this endpoint using a [token](https://docs.moov.io/api/authentication/access-tokens/) you'll need to specify the `/accounts/{accountID}/transfers.read` 
  scope.
  """)
@get
@tag("Transfers")
@route("/accounts/{accountID}/transfers")
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.read"]>)
op listTransfers(
  ...CommonHeaders,
  ...TransferListFilters,

  @format("uuid")
  @path
  accountID: string,
): ListResponses<Transfer>;

@doc("""
  Retrieve full transfer details for an individual transfer of a particular Moov account. 
  
  Payment rail-specific details are included in the source and destination. Read our [transfers overview guide](https://docs.moov.io/guides/money-movement/overview/) 
  to learn more.
  
  To access this endpoint using a [token](https://docs.moov.io/api/authentication/access-tokens/) you'll need to specify the `/accounts/{accountID}/transfers.read` 
  scope.
  """)
@get
@tag("Transfers")
@route("/accounts/{accountID}/transfers/{transferID}")
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.read"]>)
op getTransfer(
  ...CommonHeaders,

  @doc("Identifier for the transfer.")
  @format("uuid")
  @path
  transferID: string,

  @format("uuid")
  @path
  accountID: string,
): GetResponses<Transfer>;

@doc("""
  Update the metadata contained on a transfer. 
  
  Read our [transfers overview guide](https://docs.moov.io/guides/money-movement/overview/) to learn more. 
  
  To access this endpoint using a [token](https://docs.moov.io/api/authentication/access-tokens/) you'll need to specify the `/accounts/{accountID}/transfers.write` 
  scope.
  """)
@patch
@tag("Transfers")
@route("/accounts/{accountID}/transfers/{transferID}")
@useAuth(BasicAuth | OAuth2<["/accounts/{yourAccountID}/transfers.write"]>)
op patchTransfer(
  ...CommonHeaders,

  @doc("Identifier for the transfer.")
  @format("uuid")
  @path
  transferID: string,

  @format("uuid")
  @path
  accountID: string,
):
  | MoovAPI.OkResponse<Transfer>
  | MoovAPI.UnauthorizedResponse
  | MoovAPI.ForbiddenResponse
  | MoovAPI.NotFoundResponse
  | MoovAPI.RateLimitedResponse;
