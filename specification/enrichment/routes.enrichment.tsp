import "@typespec/http";
import "@typespec/openapi";
import "./models.address.tsp";
import "./models.profile.tsp";
import "./models.industries.tsp";
import "./models.avatar.tsp";
import "./models.institutions.tsp";
import "../auth/models.auth.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@get
@route("/enrichment/address")
@tag("Enriched address")
@doc("""
  Fetch enriched address suggestions. Requires a partial address. 
    
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/profile-enrichment.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/profile-enrichment.read"]>)
@useAuth(BasicAuth)
@extension("x-speakeasy-name-override", "get")
op getEnrichmentAddress(
  ...CommonHeaders,
  ...EnrichedAddressFilters,
): GetResponses<EnrichedAddressResponse>;

@get
@route("/enrichment/profile")
@tag("Enriched profile")
@doc("""
  Fetch enriched profile data. Requires a valid email address. This service is offered in collaboration with Clearbit. 
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/profile-enrichment.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/profile-enrichment.read"]>)
@useAuth(BasicAuth)
@extension("x-speakeasy-name-override", "get")
op getEnrichmentProfile(
  ...CommonHeaders,

  @example("employee@business.com")
  @query
  email: string,
): GetResponses<EnrichedBusinessProfile>;

@get
@route("/industries")
@tag("Industries")
@doc("""
  Returns a list of all industry titles and their corresponding MCC/SIC/NAICS codes. Results are ordered by title.    
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/profile-enrichment.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/profile-enrichment.read"]>)
@useAuth(BasicAuth)
@extension("x-speakeasy-name-override", "list")
op listIndustries(...CommonHeaders): ListResponses<EnrichedIndustry>;

@get
@route("/avatars/{uniqueID}")
@tag("Avatars")
@doc("""
  Get avatar image for an account using a unique ID.    
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/profile-enrichment.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/profile-enrichment.read"]>)
@useAuth(BasicAuth)
@extension("x-speakeasy-name-override", "get")
op getAvatar(
  ...CommonHeaders,

  @doc("Any unique ID associated with an account such as accountID, representativeID, routing number, or userID.")
  @path
  uniqueID: string,
):
  | EnrichedAvatar
  | UnauthorizedResponse
  | ForbiddenResponse
  | NotFoundResponse
  | RateLimitedResponse
  | InternalServerErrorResponse
  | GatewayTimeoutResponse;

@get
@route("/institutions/ach/search")
@tag("Institutions")
@doc("""
  Search for institutions by either their name or routing number.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/fed.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/fed.read"]>)
@useAuth(BasicAuth)
@extension("x-speakeasy-name-override", "search")
op listInstitutions(...CommonHeaders, ...InstitutionsFilters):
  | OkResponse<FinancialInstitutions[]>
  | BadRequestResponse
  | UnauthorizedResponse
  | ForbiddenResponse
  | RateLimitedResponse
  | InternalServerErrorResponse
  | GatewayTimeoutResponse;
