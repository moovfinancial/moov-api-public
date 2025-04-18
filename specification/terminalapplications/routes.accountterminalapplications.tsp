import "@typespec/http";
import "@typespec/openapi";
import "./models.accountterminalapplications.tsp";
import "../auth/models.auth.tsp";
import "../common/models.header.tsp";
import "../common/models.response.tsp";
import "../common/models.parameter.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@post
@route("/accounts/{accountID}/terminal-applications")
@tag("Terminal Applications")
@doc("""
  Link an account with a terminal application.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/terminal-applications.write` scope.
  """)
@extension("x-speakeasy-name-override", "create")
op linkAccountTerminalApplication(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,

  @body body: LinkAccountTerminalApplication,
): PostResponses<AccountTerminalApplication, AccountTerminalApplicationError>;

@get
@route("/accounts/{accountID}/terminal-applications/{terminalApplicationID}")
@tag("Account Terminal Applications")
@doc("""
  Verifies if a specific Terminal Application is linked to an Account. This endpoint acts as a validation check for the link's existence.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/terminal-applications.read` scope.
  """)
@extension("x-speakeasy-name-override", "get")
op getAccountTerminalApplication(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  terminalApplicationID: string,
): GetResponses<AccountTerminalApplication>;

@get
@route("/accounts/{accountID}/terminal-applications")
@tag("Account Terminal Applications")
@doc("""
  Retrieve all terminal applications linked to a specific account.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/terminal-applications.read` scope.
  """)
@extension("x-speakeasy-name-override", "list")
op listAccountTerminalApplications(
  ...CommonRequestHeaders,

  @format("uuid")
  @path
  accountID: string,
): ListResponses<AccountTerminalApplication>;
