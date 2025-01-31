import "@typespec/http";
import "@typespec/openapi";
import "./models.underwriting.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.response.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@get
@route("/accounts/{accountID}/underwriting")
@tag("Underwriting")
@doc("""
  Retrieve underwriting associated with a given Moov account. 
  
  Read our [underwriting guide](https://docs.moov.io/guides/accounts/requirements/underwriting/) to learn more. 
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/profile.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/profile.read"]>)
@extension("x-speakeasy-name-override", "get")
op getUnderwriting(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,
): GetResponses<Underwriting>;

@put
@route("/accounts/{accountID}/underwriting")
@tag("Underwriting")
@doc("""
  Update the account's underwriting by passing new values for one or more of the fields. 
  
  Read our [underwriting guide](https://docs.moov.io/guides/accounts/requirements/underwriting/) to learn more.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/profile.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/profile.write"]>)
@extension("x-speakeasy-name-override", "update")
op updateUnderwriting(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,

  @body body: UpdateUnderwriting,
): UpdateResponses<Underwriting, UpdateUnderwritingError>;
