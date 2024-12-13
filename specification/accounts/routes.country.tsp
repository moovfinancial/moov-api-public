import "@typespec/http";
import "./models.country.tsp";
import "../auth/models.auth.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";

using TypeSpec.Http;

namespace MoovAPI;

@doc("""
  Retrieve the specified countries of operation for an account. 
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/profile.read` scope when generating 
  a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@tag("Accounts")
@route("/accounts/{accountID}/countries")
@get
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/profile.read"]>)
op getAccountCountries(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,
): GetResponses<AccountCountries>;

@doc("""
  Assign the countries of operation for an account.
  
  This endpoint will always overwrite the previously assigned values. 
  
  To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/profile.write` scope when generating 
  a [token](https://docs.moov.io/api/authentication/access-tokens/).
  """)
@tag("Accounts")
@route("/accounts/{accountID}/countries")
@put
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/profile.write"]>)
op assignAccountCountries(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @body countries: AccountCountries,
): UpdateResponses<AccountCountries, AssignCountriesError>;
