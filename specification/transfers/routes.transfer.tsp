import "@typespec/http";
import "@typespec/openapi";
import "./models.transfer.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

// TODO: refactor TransfersBff2 responses to use the standardized response codes and bodies from go-http.
namespace MoovAPI;

@post
@route("/accounts/{accountID}/transfers")
@tag("Transfers")
@doc("""
  Move money by providing the source, destination, and amount in the request body.
  
  Read our [transfers overview guide](https://docs.moov.io/guides/money-movement/overview/) to learn more. 
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.write"]>)
@opExample(ExampleCreateTransferAsync, #{ title: "Created async transfer" })
@opExample(
  ExampleCreateTransferSync,
  #{ title: "Created synchronous transfer" }
)
@extension("x-speakeasy-name-override", "create")
op createTransfer(
  ...CommonRequestHeaders,

  @doc("Prevents duplicate transfers from being created.")
  @format("uuid")
  @header
  xIdempotencyKey: string,

  @doc("""
    Optional header that indicates whether to return a synchronous response that includes full transfer and rail-specific details or an 
    asynchronous response indicating the transfer was created (this is the default response if the header is omitted). A timeout will occur after 25 seconds.
    """)
  @header
  xWaitFor?: TransferWaitFor,

  @doc("The merchant's Moov account ID.")
  @format("uuid")
  @path
  accountID: string,

  @body body: CreateTransfer,
):
  | OkResponse<CreatedTransfer>
  | CreatedTransferSyncErrorResponse
  | CreateTransferTimeoutResponse
  | BadRequestResponse
  | NotFoundResponse
  | DuplicateTransferResponse
  | UnprocessableEntityResponse<TransferValidationError>
  | RateLimitedResponse
  | InternalServerErrorResponse
  | GatewayTimeoutResponse;

@get
@route("/accounts/{accountID}/transfers")
@tag("Transfers")
@doc("""
  List all the transfers associated with a particular Moov account. 
  
  Read our [transfers overview guide](https://docs.moov.io/guides/money-movement/overview/) to learn more. 
  
  When you run this request, you retrieve 200 transfers at a time. You can advance past a results set of 200 transfers by using the `skip` parameter (for example, 
  if you set `skip`= 10, you will see a results set of 200 transfers after the first 10). If you are searching a high volume of transfers, the request will likely 
  process very slowly. To achieve faster performance, restrict the data as much as you can by using the `StartDateTime` and `EndDateTime` parameters for a limited 
  period of time. You can run multiple requests in smaller time window increments until you've retrieved all the transfers you need.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.read"]>)
@extension("x-speakeasy-name-override", "list")
op listTransfers(
  ...CommonRequestHeaders,
  ...TransferListFilters,

  @format("uuid")
  @path
  accountID: string,
): ListResponses<Transfer>;

@get
@route("/accounts/{accountID}/transfers/{transferID}")
@tag("Transfers")
@doc("""
  Retrieve full transfer details for an individual transfer of a particular Moov account. 
  
  Payment rail-specific details are included in the source and destination. Read our [transfers overview guide](https://docs.moov.io/guides/money-movement/overview/) 
  to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.read"]>)
@extension("x-speakeasy-name-override", "get")
op getTransfer(
  ...CommonRequestHeaders,

  @doc("Identifier for the transfer.")
  @format("uuid")
  @path
  transferID: string,

  @format("uuid")
  @path
  accountID: string,
): GetResponses<Transfer>;

@patch
@route("/accounts/{accountID}/transfers/{transferID}")
@tag("Transfers")
@doc("""
  Update the metadata contained on a transfer. 
  
  Read our [transfers overview guide](https://docs.moov.io/guides/money-movement/overview/) to learn more. 
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.write"]>)
@extension("x-speakeasy-name-override", "update")
op updateTransfer(
  ...CommonRequestHeaders,

  @doc("Identifier for the transfer.")
  @format("uuid")
  @path
  transferID: string,

  @format("uuid")
  @path
  accountID: string,

  @body body: PatchTransfer,
):
  | OkResponse<Transfer>
  | UnauthorizedResponse
  | ForbiddenResponse
  | NotFoundResponse
  | RateLimitedResponse
  | InternalServerErrorResponse
  | GatewayTimeoutResponse;
