import "@typespec/http";
import "./models.address.tsp";
import "./models.profile.tsp";
import "./models.industries.tsp";
import "./models.avatar.tsp";
import "./models.institutions.tsp";
import "../auth/models.auth.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";

using TypeSpec.Http;

namespace MoovAPI {
  @doc("""
      Fetch enriched address suggestions. Requires a partial address. 
      
      To use this endpoint from the browser, you'll need to specify the `/profile-enrichment.read` scope when generating a [token](https://docs.moov.io/api/authentication/access-tokens/).
    """)
  @tag("Enriched address")
  @route("/enrichment/address")
  @get
  @useAuth(BasicAuth | OAuth2<["/profile-enrichment.read"]>)
  op getEnrichmentAddress(
    ...CommonHeaders,
    ...EnrichedAddressFilters,
  ): GetResponses<EnrichedAddressResponse>;

  @doc("""
      Fetch enriched profile data. Requires a valid email address. This service is offered in collaboration with Clearbit. 
    
      To use this endpoint from the browser, you'll need to specify the `/profile-enrichment.read` scope when generating a [token](https://docs.moov.io/api/authentication/access-tokens/).
    """)
  @tag("Enriched profile")
  @route("/enrichment/profile")
  @get
  @useAuth(BasicAuth | OAuth2<["/profile-enrichment.read"]>)
  op getEnrichmentProfile(
    ...CommonHeaders,

    @example("employee@business.com")
    @query
    email: string,
  ): GetResponses<EnrichedBusinessProfile>;

  @doc("""
      Returns a list of all industry titles and their corresponding MCC/SIC/NAICS codes. Results are ordered by title.    
      
      To use this endpoint from the browser, you'll need to specify the `/profile-enrichment.read` scope when generating a [token](https://docs.moov.io/api/authentication/access-tokens/).
    """)
  @tag("Industries")
  @route("/industries")
  @get
  @useAuth(BasicAuth | OAuth2<["/profile-enrichment.read"]>)
  op listIndustries(...CommonHeaders): ListResponses<EnrichedIndustry>;

  @doc("""
    Get avatar image for an account using a unique ID.    
    
    To use this endpoint from the browser, you'll need to specify the `/profile-enrichment.read` scope when generating a [token](https://docs.moov.io/api/authentication/access-tokens/).
    """)
  @tag("Avatars")
  @route("/avatars/{uniqueID}")
  @get
  @useAuth(BasicAuth | OAuth2<["/profile-enrichment.read"]>)
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
    | RateLimitedResponse;

  @doc("""
      Search for institutions by either their name or routing number.
      
      To use this endpoint from the browser, you'll need to specify the `/fed.read` scope when generating a [token](https://docs.moov.io/api/authentication/access-tokens/).
    """)
  @tag("Institutions")
  @route("/institutions/ach/search")
  @get
  @useAuth(BasicAuth | OAuth2<["/fed.read"]>)
  op listInstitutions(...CommonHeaders): ListResponses<AchParticipants>;
}
