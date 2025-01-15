import "@typespec/http";
import "../accounts/models.representative.tsp";
import "./model.representatives.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;

namespace MoovAPI;

@doc("""
  Moov accounts associated with businesses require information regarding individuals who represent the business. 
  You can provide this information by creating a representative. Each account is allowed a maximum of 7 representatives. 
  Read our [business representatives guide](https://docs.moov.io/guides/accounts/requirements/business-representatives/) to learn more.
  
  To use this endpoint from the browser, you’ll need to specify the /accounts/{accountID}/representatives.write scope when generating a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@post
@route("/accounts/{accountID}/representatives")
@tag("Representatives")
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/representatives.write"]>)
op createRepresentative(
  ...CommonHeaders,

  @doc("The merchant's Moov account ID.")
  @format("uuid")
  @path
  accountID: string,

  @body body: CreateRepresentative,
):
  | MoovAPI.OkResponse<Representative>
  | MoovAPI.BadRequestResponse
  | MoovAPI.NotFoundResponse
  | MoovAPI.UnprocessableEntityResponse<RepresentativeValidationError>
  | MoovAPI.RateLimitedResponse;
