import "@typespec/http";
import "./models.address.tsp";
import "./models.profile.tsp";
import "./models.avatar.tsp";
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
    Get avatar image for an account using a unique ID.    
    
    To use this endpoint from the browser, you'll need to specify the `/profile-enrichment.read` scope when generating a [token](https://docs.moov.io/api/authentication/access-tokens/).
    """)
  @tag("Enriched profile")
  @route("/avatars/{uniqueID}")
  @get
  @useAuth(BasicAuth | OAuth2<["/profile-enrichment.read"]>)
  op getAvatar(
    ...CommonHeaders,

    @doc("Any unique ID associated with an account such as accountID, representativeID, routing number, or userID.")
    @format("uuid")
    @path
    uniqueID: string,
  ): GetResponses<EnrichedAvatarResponse>;
}
