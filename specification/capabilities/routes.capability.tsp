import "@typespec/http";
import "./models.capability.tsp";
import "../auth/models.auth.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";

using TypeSpec.Http;

namespace MoovAPI {
  @doc("""
    Retrieve all the capabilities an account has requested.
    
    Read our [capabilities guide](https://docs.moov.io/guides/accounts/capabilities/) to learn more.
    """)
  @tag("Capabilities")
  @route("/accounts/{accountID}/capabilities")
  @get
  @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/capabilities.read"]>)
  op listAccountCapabilities(
    ...CommonHeaders,

    @format("uuid")
    @path
    accountID: string,
  ): ListResponses<Capability>;
}
