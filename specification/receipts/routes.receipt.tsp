import "@typespec/http";
import "@typespec/openapi";
import "./models.receipt.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@post
@route("/receipts")
@tag("Receipts")
@doc("""
   Create receipts for transfers and scheduled transfers.
  
   To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
   you'll need to specify the `/accounts/{accountID}/transfers.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/receipts.write"]>)
@extension("x-speakeasy-name-override", "create")
op createReceipts(
  ...CommonRequestHeaders,

  @body
  body: ReceiptRequest[],
): PostResponsesCreated<ReceiptResponse[], ReceiptValidationErrorResponse>;

@get
@route("/receipts")
@tag("Receipts")
@doc("""
  List receipts by transferID, scheduleID, or occurrenceID.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/receipts.read"]>)
@extension("x-speakeasy-name-override", "list")
op listReceipts(
  ...CommonRequestHeaders,

  @doc("The transfer, schedule, or transfer occurrence ID to filter receipts by.")
  @format("uuid")
  @query
  id: string,
): ListResponses<ReceiptResponse>;
