import "@typespec/http";
import "./models.mpa.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;

namespace MoovAPI;

@get
@route("/accounts/{accountID}/merchant-agreement")
@tag("Accounts")
@doc("""
  Retrieve a merchant account's processing agreement.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/profile.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/profile.read"]>)
op getMerchantProcessingAgreement(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,
):
  | PDFResponse
  | UnauthorizedResponse
  | ForbiddenResponse
  | NotFoundResponse
  | RateLimitedResponse
  | InternalServerErrorResponse
  | GatewayTimeoutResponse;
