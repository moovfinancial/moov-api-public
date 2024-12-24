import "@typespec/http";
import "./examples.dispute.tsp";
import "./models.dispute.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;

namespace MoovAPI;

@doc("""
  Returns the list of disputes. 
  
  Read our [disputes guide](https://docs.moov.io/guides/money-movement/accept-payments/card-acceptance/disputes/) to learn more.
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/transfers.read` scope when generating 
  a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@get
@tag("Disputes")
@route("/accounts/{accountID}/disputes")
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.read"]>)
@opExample(#{ returnType: #{ statusCode: 200, body: #[ExampleDispute] } })
op listDisputes(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  ...DisputeListFilters,
): ListResponses<Dispute>;

@doc("""
  Get a dispute by ID. 
  
  Read our [disputes guide](https://docs.moov.io/guides/money-movement/accept-payments/card-acceptance/disputes/) to learn more.
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/transfers.read` scope when generating 
  a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@get
@tag("Disputes")
@route("/accounts/{accountID}/disputes/{disputeID}")
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.read"]>)
@opExample(#{ returnType: #{ statusCode: 200, body: ExampleDispute } })
op getDispute(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  disputeID: string,
): GetResponses<Dispute>;

@doc("""
  Accepts a dispute. 
  
  Read our [disputes guide](https://docs.moov.io/guides/money-movement/accept-payments/card-acceptance/disputes/) to learn more.
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/transfers.write` scope when generating 
  a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@post
@tag("Disputes")
@route("/accounts/{accountID}/disputes/{disputeID}/accept")
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/transfers.write"]>)
@opExample(#{ returnType: #{ statusCode: 200, body: ExampleAcceptedDispute } })
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
  | RateLimitedResponse;
