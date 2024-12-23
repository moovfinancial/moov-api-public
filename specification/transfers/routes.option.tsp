import "@typespec/http";
import "./models.options.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;

namespace MoovAPI;

@doc("""
  Generate available payment method options for one or multiple transfer participants depending on the accountID or paymentMethodID you 
  supply in the request. 
  
  Read our [transfers overview guide](https://docs.moov.io/guides/money-movement/overview/) to learn more.
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{yourAccountID}/transfers.read` scope when generating a 
  [token](https://docs.moov.io/api/authentication/access-tokens/). The accountID included must be your accountID. You can find your 
  accountID on the [Business details](https://dashboard.moov.io/settings/business) page.
  """)
@post
@route("/transfer-options")
@tag("Transfers")
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.read"]>)
op createTransferOptions(...CommonHeaders):
  | OkResponse<TransferOptions>
  | BadRequestResponse
  | UnauthorizedResponse
  | ForbiddenResponse
  | UnprocessableEntityResponse<TransferOptionsValidationError>
  | RateLimitedResponse;
