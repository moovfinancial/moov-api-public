import "@typespec/http";
import "@typespec/openapi";
import "./models.adjustments.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@get
@route("/accounts/{accountID}/adjustments")
@tag("Adjustments")
@doc("""
  List adjustments associated with a Moov account.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/wallets.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/wallets.read"]>)
@extension("x-speakeasy-name-override", "list")
op listAdjustments(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,

  @doc("A wallet ID to filter adjustments by.")
  @format("uuid")
  @query
  walletID?: string,
): ListResponses<Adjustment>;

@get
@route("/accounts/{accountID}/adjustments/{adjustmentID}")
@tag("Adjustments")
@doc("""
  Retrieve a specific adjustment associated with a Moov account.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/wallets.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/wallets.read"]>)
@extension("x-speakeasy-name-override", "get")
op getAdjustment(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  adjustmentID: string,
): GetResponses<Adjustment>;
