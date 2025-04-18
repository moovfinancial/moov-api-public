import "@typespec/http";
import "@typespec/openapi";
import "./models.terminalapplications.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.response.tsp";
import "../common/models.parameter.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@post
@route("/terminal-applications")
@tag("Terminal Applications")
@doc("""
  Create a new terminal application.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/terminal-applications.write` scope.
  """)
@extension("x-speakeasy-name-override", "create")
op createTerminalApplication(
  ...CommonRequestHeaders,
  @body body: CreateTerminalApplication,
): PostResponses<TerminalApplication, TerminalApplicationError>;

@get
@route("/terminal-applications")
@tag("Terminal Applications")
@doc("""
  List all the terminal applications for a Moov Account.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/terminal-applications.read` scope.
  """)
@extension("x-speakeasy-name-override", "list")
op listTerminalApplications(
  ...CommonRequestHeaders,
): ListResponses<TerminalApplication>;

@get
@route("/terminal-applications/{terminalApplicationID}")
@tag("Terminal Applications")
@doc("""
  Fetch a specific terminal application.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/terminal-applications.read` scope.
  """)
@extension("x-speakeasy-name-override", "get")
op getTerminalApplication(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  terminalApplicationID: string,
): GetResponses<TerminalApplication>;

@delete
@route("/terminal-applications/{terminalApplicationID}")
@tag("Terminal Applications")
@doc("""
  Delete a specific terminal application.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/terminal-applications.write` scope.
  """)
@extension("x-speakeasy-name-override", "delete")
op deleteTerminalApplication(
  ...CommonRequestHeaders,

  @path
  @format("uuid")
  terminalApplicationID: string,
): DisableResponses;
