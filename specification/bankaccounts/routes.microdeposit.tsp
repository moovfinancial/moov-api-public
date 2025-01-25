import "@typespec/http";
import "./models.microdeposits.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";
import "../auth/models.auth.tsp";

using TypeSpec.Http;

namespace MoovAPI;

@post
@route("/accounts/{accountID}/bank-accounts/{bankAccountID}/micro-deposits")
@tag("Bank accounts")
@doc("""
  Micro-deposits help confirm bank account ownership, helping reduce fraud and the risk of unauthorized activity. 
  Use this method to initiate the micro-deposit verification, sending two small credit transfers to the bank account 
  you want to confirm.
  
  If you request micro-deposits before 4:15PM ET, they will appear that same day. If you request micro-deposits any 
  time after 4:15PM ET, they will appear the next banking day. When the two credits are initiated, Moov simultaneously
  initiates a debit to recoup the micro-deposits. 
  
  Micro-deposits initiated for a `sandbox` bank account will always be `$0.00` / `$0.00` and instantly verifiable once initiated.
  
  You can simulate micro-deposit verification in test mode. See our [test mode](https://docs.moov.io/guides/get-started/test-mode/#micro-deposits)
  guide for more information.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/bank-accounts.write` scope.
  """)
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/bank-accounts.write"]>)
op initiateMicroDeposits(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  bankAccountID: string,
):
  | NoContentResponse
  | BadRequestResponse
  | UnauthorizedResponse
  | ForbiddenResponse
  | NotFoundResponse
  | StateConflictResponse
  | RateLimitedResponse
  | InternalServerErrorResponse
  | GatewayTimeoutResponse;

@put
@route("/accounts/{accountID}/bank-accounts/{bankAccountID}/micro-deposits")
@tag("Bank accounts")
@doc("""
  Complete the micro-deposit validation process by passing the amounts of the two transfers within three tries.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/bank-accounts.write` scope.
  """)
@useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/bank-accounts.write"]>)
op completeMicroDeposits(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  bankAccountID: string,

  @body body: CompleteMicroDeposits,
): UpdateResponses<CompletedMicroDeposits, MicroDepositValidationError>;
