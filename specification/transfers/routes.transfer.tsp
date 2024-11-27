import "@typespec/http";
import "./models.transfer.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;

// TODO: refactor TransfersBff2 responses to use the standardized response codes and bodies from go-http.
namespace MoovAPI {
  @doc("""
    Move money by providing the source, destination, and amount in the request body. 
    Read our [transfers overview guide](https://docs.moov.io/guides/money-movement/overview/) to learn more. 
    
    If you are running a **server-side** integration, you will use your API keys per our 
    [authentication guidelines](https://docs.moov.io/api/authentication/api-authentication/#server-side-basic-authentication). If you
    are running a **client-side** integration, you'll need to specify the `/accounts/{yourAccountID}/transfers.write` scope when generating
    a [token](https://docs.moov.io/api/authentication/access-tokens/). The accountID included must be your accountID. You can find your 
    accountID on the [Business details](https://dashboard.moov.io/settings/business) page.
    """)
  @post
  @route("/transfers")
  @tag("Transfers")
  @useAuth(BasicAuth | OAuth2<["/accounts/{yourAccountID}/transfers.write"]>)
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
    
    To use this endpoint from the browser, you'll need to specify the `/accounts/{yourAccountID}/transfers.read` scope when generating a 
    [token](https://docs.moov.io/api/authentication/access-tokens/). The accountID included must be your accountID. You can find your 
    accountID on the [Business details](https://dashboard.moov.io/settings/business) page.
    
    When you run this request, you retrieve 200 transfers at a time. You can advance past a results set of 200 transfers by using the 
    `skip` parameter (for example, if you set `skip`= 10, you will see a results set of 200 transfers after the first 2000). If you are 
    searching a high volume of transfers, the request will likely process very slowly. To achieve faster performance, restrict the data 
    as much as you can by using the `StartDateTime` and `EndDateTime` parameters for a limited period of time. You can run multiple 
    requests in smaller time window increments until you've retrieved all the transfers you need.
    """)
  @get
  @tag("Transfers")
  @route("/transfers")
  @useAuth(BasicAuth | OAuth2<["/accounts/{yourAccountID}/transfers.read"]>)
  op listTransfers(
    ...CommonHeaders,
    ...TransferListFilters,
  ): ListResponses<Transfer>;

  @doc("""
    Retrieve full transfer details such as the amount, source, and destination. Payment rail-specific details are included in the source
    and destination. Read our [transfers overview guide](https://docs.moov.io/guides/money-movement/overview/) to learn more.
    
    To use this endpoint from the browser, you'll need to specify the `/accounts/{yourAccountID}/transfers.read` scope when generating a
    [token](https://docs.moov.io/api/authentication/access-tokens/). The accountID included must be your accountID. You can find your 
    accountID on the [Business details](https://dashboard.moov.io/settings/business) page.
    """)
  @get
  @tag("Transfers")
  @route("/transfers/{transferID}")
  @useAuth(BasicAuth | OAuth2<["/accounts/{yourAccountID}/transfers.read"]>)
  op getTransfer(
    ...CommonHeaders,

    @doc("Identifier for the transfer.")
    @path
    transferID: string,

    @doc("Identifier for a connected account. Must be provided when using a token and the value of `{accountID}` in the scopes is a connected account.")
    @query
    accountID?: string,
  ): GetResponses<Transfer>;

  @doc("""
    Update the metadata contained on a transfer. 
    
    Read our [transfers overview guide](https://docs.moov.io/guides/money-movement/overview/) to learn more. To use this endpoint from the browser, you'll 
    need to specify the `/accounts/{yourAccountID}/transfers.write` scope when generating a [token](https://docs.moov.io/api/authentication/access-tokens/). 
    The accountID included must be your facilitator accountID. You can find your accountID on the [Business details](https://dashboard.moov.io/settings/business) 
    page.
    """)
  @patch
  @tag("Transfers")
  @route("/transfers/{transferID}")
  @useAuth(BasicAuth | OAuth2<["/accounts/{yourAccountID}/transfers.write"]>)
  op patchTransfer(
    ...CommonHeaders,

    @doc("Identifier for the transfer.")
    @path
    transferID: string,

    @doc("Identifier for a connected account. Must be provided when using a token and the value of `{accountID}` in the scopes is a connected account.")
    @query
    accountID?: string,
  ):
    | MoovAPI.OkResponse<Transfer>
    | MoovAPI.UnauthorizedResponse
    | MoovAPI.ForbiddenResponse
    | MoovAPI.NotFoundResponse
    | MoovAPI.RateLimitedResponse;

  @doc("""
    List all the transfers associated with a particular Moov account. Read our [transfers overview guide](https://docs.moov.io/guides/money-movement/overview/) to learn more. 
    
    To access this endpoint using a [token](https://docs.moov.io/api/authentication/access-tokens/) you'll need to specify the `/accounts/{accountID}/transfers.read` scope. The
    accountID included must match the accountID being requested. 
    
    When you run this request, you retrieve 200 transfers at a time. You can advance past a results set of 200 transfers by using the `skip` parameter (for example, if you set 
    `skip`= 10, you will see a results set of 200 transfers after the first 2000). If you are searching a high volume of transfers, the request will likely process very slowly. 
    To achieve faster performance, restrict the data as much as you can by using the `StartDateTime` and `EndDateTime` parameters for a limited period of time. You can run 
    multiple requests in smaller time window increments until you've retrieved all the transfers you need.
    """)
  @get
  @tag("Transfers")
  @route("/accounts/{accountID}/transfers")
  @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.read"]>)
  op listTransfersForAccount(
    ...CommonHeaders,

    @doc("Identifier for the account.")
    @path
    accountID: string,

    ...TransferListFilters,
  ): ListResponses<Transfer>;

  @doc("""
    Retrieve full transfer details for an individual transfer of a particular Moov account. 
    
    Payment rail-specific details are included in the source and destination. Read our [transfers overview guide](https://docs.moov.io/guides/money-movement/overview/) to learn
    more. 
    
    To access this endpoint using a [token](https://docs.moov.io/api/authentication/access-tokens/) you'll need to specify the `/accounts/{accountID}/transfers.read` scope. The 
    accountID included must match the accountID being requested.
    """)
  @get
  @tag("Transfers")
  @route("/accounts/{accountID}/transfers/{transferID}")
  @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.read"]>)
  op getTransferForAccount(
    ...CommonHeaders,

    @doc("Identifier for the account.")
    @path
    accountID: string,

    @doc("Identifier for the transfer.")
    @path
    transferID: string,
  ): GetResponses<Transfer>;
}
