import "@typespec/http";
import "@typespec/openapi";
import "./models.country.tsp";
import "../auth/models.auth.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@get
@route("/accounts/{accountID}/countries")
@tag("Accounts")
@doc("""
  Retrieve the specified countries of operation for an account. 
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/profile.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/profile.read"]>)
@extension("x-speakeasy-name-override", "getCountries")
op getAccountCountries(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,
): GetResponses<AccountCountries>;

@put
@route("/accounts/{accountID}/countries")
@tag("Accounts")
@doc("""
  Assign the countries of operation for an account.
  
  This endpoint will always overwrite the previously assigned values. 
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/profile.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/profile.write"]>)
@extension("x-speakeasy-name-override", "assignCountries")
op assignAccountCountries(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @body countries: AccountCountries,
): UpdateResponses<AccountCountries, AssignCountriesError>;
