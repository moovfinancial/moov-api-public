import "@typespec/http";
import "./models.address.tsp";
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
}
