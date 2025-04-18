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
@tag("Account Terminal Applications")
@doc("""
  Link an account with a terminal application.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/terminal-applications.write` scope.
  """)
@extension("x-speakeasy-name-override", "link")
op linkAccountTerminalApplication(
  ...CommonRequestHeaders,

  @path
  accountID: MerchantAccountID,

  @body body: LinkAccountTerminalApplication,
): PostResponses<TerminalApplication, AccountTerminalApplicationError>;

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

  @path
  accountID: MerchantAccountID,

  @path
  terminalApplicationID: TerminalApplicationID,
): GetResponses<TerminalApplication>;

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

  @path
  accountID: MerchantAccountID,
): ListResponses<TerminalApplication>;
