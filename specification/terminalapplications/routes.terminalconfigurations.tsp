import "@typespec/http";
import "@typespec/openapi";
import "./models.terminalapplications.tsp";
import "./models.terminalconfigurations.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.response.tsp";
import "../common/models.parameter.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace MoovAPI;

@get
@route("/accounts/{accountID}/terminal-applications/{terminalApplicationID}/configuration")
@tag("Terminal Configurations")
@doc("""
  Fetch the configuration for a given Terminal Application
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/terminal-configuration.read` scope.
  """)
@extension("x-speakeasy-name-override", "get")
op getTerminalConfiguration(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,

  @path
  terminalApplicationID: TerminalApplicationID,
): GetResponses<TerminalConfiguration>;
