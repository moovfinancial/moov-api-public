import "@typespec/http";
import "./models.capability.tsp";
import "../auth/models.auth.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";

using TypeSpec.Http;

@tag("Capabilities")
@route("/accounts/{accountID}/capabilities")
namespace MoovAPI.Capabilities {
  @doc("""
    Retrieve all the capabilities an account has requested.
    
    Read our [capabilities guide](https://docs.moov.io/guides/accounts/capabilities/) to learn more.
    """)
  @get
  @useAuth(Auth.OAuth2<["/accounts/{accountID}/capabilities.read"]> | BasicAuth)
  op listAccountCapabilities(
    ...Common.Headers,

    @format("uuid")
    @path
    accountID: string,
  ): Common.List<Capabilities.Capability>;
}
