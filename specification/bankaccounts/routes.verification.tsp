import "@typespec/http";
import "./models.verification.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";
import "../auth/models.auth.tsp";

using TypeSpec.Http;

namespace MoovAPI {
  @doc("""
    Retrieve the current status and details of an instant verification, including whether the verification method was instant or same-day 
    ACH. This helps track the verification process in real-time and provides details in case of exceptions.
    
    The status will indicate the following:
    
    - `new`: Verification initiated, credit pending to the payment network
    - `sent-credit`: Credit sent, available for verification
    - `failed`: Verification failed, description provided, user needs to add a new bank account
    - `expired`: Verification expired after 14 days, initiate another verification
    - `max-attempts-exceeded`: Five incorrect code attempts exhausted, initiate another verification
    
    To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/bank-accounts.read` scope when generating a 
    [token](https://docs.moov.io/api/authentication/access-tokens/).
    """)
  @tag("Bank accounts")
  @route("/accounts/{accountID}/bank-accounts/{bankAccountID}/verify")
  @get
  @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/bank-accounts.read"]>)
  op getBankAccountVerification(
    ...CommonHeaders,

    @format("uuid")
    @path
    accountID: string,

    @format("uuid")
    @path
    bankAccountID: string,
  ): GetResponses<BankAccountVerification>;

  @doc("""
    Instant micro-deposit verification offers a quick and efficient way to verify bank account ownership. 
    
    Send a $0.01 credit with a unique verification code via RTP or same-day ACH, depending on the receiving bank’s capabilities. This
    feature provides a faster alternative to traditional methods, allowing verification in a single session.
    
    It is recommended to use the `X-Wait-For: rail-response` header to synchronously receive the outcome of the instant credit in the
     response payload.
    
    Possible verification methods:
      - `instant`: Real-time verification credit sent via RTP
      - `ach`: Verification credit sent via same-day ACH
    
    Possible statuses:
      - `new`: Verification initiated, credit pending
      - `sent-credit`: Credit sent, available for verification in the external bank account
      - `failed`: Verification failed due to credit rejection/return, details in `exceptionDetails`
    
    To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/bank-accounts.write` scope when generating a 
    [token](https://docs.moov.io/api/authentication/access-tokens/).
    """)
  @tag("Bank accounts")
  @route("/accounts/{accountID}/bank-accounts/{bankAccountID}/verify")
  @post
  @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/bank-accounts.write"]>)
  op initiateBankAccountVerification(
    ...CommonHeaders,

    @doc("""
      Optional header to wait for certain events, such as the rail response, to occur before returning a response.
      
      When this header is set to `rail-response`, the endpoint will wait for a sent-credit or failed status from the payment rail.
      """)
    @header
    xWaitFor: BankAccountWaitFor,

    @format("uuid")
    @path
    accountID: string,

    @format("uuid")
    @path
    bankAccountID: string,
  ):
    | OkResponse<BankAccountVerificationCreated>
    | BadRequestResponse
    | UnauthorizedResponse
    | ForbiddenResponse
    | NotFoundResponse
    | StateConflictResponse
    | RateLimitedResponse
    | InternalServerErrorResponse
    | GatewayTimeoutResponse;

  @doc("""
    Finalize the instant micro-deposit verification by submitting the verification code displayed in the user’s bank account. 
    
    Upon successful verification, the bank account status will be updated to `verified` and eligible for ACH debit transactions.
    
    The following formats are accepted:
    - `MV0000`
    - `mv0000`
    - `0000`
    
    To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/bank-accounts.write` scope when 
    generating a [token](https://docs.moov.io/api/authentication/access-tokens/).
    """)
  @tag("Bank accounts")
  @route("/accounts/{accountID}/bank-accounts/{bankAccountID}/verify")
  @put
  @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/bank-accounts.write"]>)
  op completeBankAccountVerification(
    ...CommonHeaders,

    @format("uuid")
    @path
    accountID: string,

    @format("uuid")
    @path
    bankAccountID: string,

    @body body: CompleteBankAccountVerification,
  ): UpdateResponses<BankAccountVerification, GenericError>;
}
