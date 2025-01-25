import "@typespec/http";
import "@typespec/openapi";
import "./examples.dispute.tsp";
import "./models.dispute.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@get
@route("/accounts/{accountID}/disputes")
@tag("Disputes")
@doc("""
  Returns the list of disputes. 
  
  Read our [disputes guide](https://docs.moov.io/guides/money-movement/accept-payments/card-acceptance/disputes/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.read` scope.
  """)
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.read"]>)
@opExample(#{ returnType: #{ statusCode: 200, body: #[ExampleDispute] } })
@extension("x-speakeasy-name-override", "list")
op listDisputes(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  ...DisputeListFilters,
): ListResponses<Dispute>;

@get
@tag("Disputes")
@route("/accounts/{accountID}/disputes/{disputeID}")
@doc("""
  Get a dispute by ID. 
  
  Read our [disputes guide](https://docs.moov.io/guides/money-movement/accept-payments/card-acceptance/disputes/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.read` scope.
  """)
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.read"]>)
@opExample(#{ returnType: #{ statusCode: 200, body: ExampleDispute } })
@extension("x-speakeasy-name-override", "get")
op getDispute(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  disputeID: string,
): GetResponses<Dispute>;

@post
@tag("Disputes")
@route("/accounts/{accountID}/disputes/{disputeID}/accept")
@doc("""
  Accepts liability for a dispute. 
  
  Read our [disputes guide](https://docs.moov.io/guides/money-movement/accept-payments/card-acceptance/disputes/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/transfers.read` scope.
  """)
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.write"]>)
@opExample(#{ returnType: #{ statusCode: 200, body: ExampleAcceptedDispute } })
@extension("x-speakeasy-name-override", "accept")
op acceptDispute(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  disputeID: string,
):
  | OkResponse<Dispute>
  | BadRequestResponse
  | UnauthorizedResponse
  | ForbiddenResponse
  | NotFoundResponse
  | StateConflictResponse
  | RateLimitedResponse
  | InternalServerErrorResponse
  | GatewayTimeoutResponse;
