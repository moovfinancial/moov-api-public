import "@typespec/http";
import "@typespec/openapi";
import "./models.options.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@post
@route("/transfer-options")
@tag("Transfers")
@doc("""
  Generate available payment method options for one or multiple transfer participants depending on the accountID or paymentMethodID you 
  supply in the request. 
  
  Read our [transfers overview guide](https://docs.moov.io/guides/money-movement/overview/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.read"]>)
@extension("x-speakeasy-name-override", "generateOptions")
op createTransferOptions(...CommonHeaders):
  | OkResponse<TransferOptions>
  | BadRequestResponse
  | UnauthorizedResponse
  | ForbiddenResponse
  | UnprocessableEntityResponse<TransferOptionsValidationError>
  | RateLimitedResponse
  | InternalServerErrorResponse
  | GatewayTimeoutResponse;
