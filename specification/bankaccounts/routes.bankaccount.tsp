import "@typespec/http";
import "@typespec/openapi";
import "./models.bankaccount.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";
import "../auth/models.auth.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace MoovAPI;

@post
@route("/accounts/{accountID}/bank-accounts")
@tag("Bank accounts")
@doc("""
  Link a bank account to an existing Moov account. Read our [bank accounts guide](https://docs.moov.io/guides/sources/bank-accounts/) to learn more.
  
  It is strongly recommended that callers include the `X-Wait-For` header, set to `payment-method`, if the newly linked
  bank-account is intended to be used right away. If this header is not included, the caller will need to poll the [List Payment
  Methods](https://docs.moov.io/api/sources/payment-methods/list/)
  endpoint to wait for the new payment methods to be available for use.
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/bank-accounts.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/bank-accounts.write"]>)
@extension("x-speakeasy-name-override", "link")
op linkBankAccount(
  ...CommonHeaders,

  @doc("""
    Optional header to wait for certain events, such as the creation of a payment method, to occur before returning a response.
    
    When this header is set to `payment-method`, the response will include any payment methods that were created for the newly
    linked card in the `paymentMethods` field. Otherwise, the `paymentMethods` field will be omitted from the response.
    """)
  @header
  xWaitFor?: BankAccountWaitFor,

  @format("uuid")
  @path
  accountID: string,

  @body body: LinkBankAccount,
): PostResponses<BankAccount, BankAccountValidationError>;

@get
@route("/accounts/{accountID}/bank-accounts")
@tag("Bank accounts")
@doc("""
  List all the bank accounts associated with a particular Moov account. 
  
  Read our [bank accounts guide](https://docs.moov.io/guides/sources/bank-accounts/) to learn more. 
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/bank-accounts.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/bank-accounts.read"]>)
@extension("x-speakeasy-name-override", "list")
op listBankAccounts(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,
): ListResponses<BankAccount>;

@get
@route("/accounts/{accountID}/bank-accounts/{bankAccountID}")
@tag("Bank accounts")
@doc("""
  Retrieve bank account details (i.e. routing number or account type) associated with a specific Moov account. 
  
  Read our [bank accounts guide](https://docs.moov.io/guides/sources/bank-accounts/) to learn more. 
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/bank-accounts.read` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/bank-accounts.read"]>)
@extension("x-speakeasy-name-override", "get")
op getBankAccount(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  bankAccountID: string,
): GetResponses<BankAccount>;

@delete
@route("/accounts/{accountID}/bank-accounts/{bankAccountID}")
@tag("Bank accounts")
@doc("""
  Discontinue using a specified bank account linked to a Moov account. 
  
  To access this endpoint using an [access token](https://docs.moov.io/api/authentication/access-tokens/) 
  you'll need to specify the `/accounts/{accountID}/bank-accounts.write` scope.
  """)
// @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/bank-accounts.write"]>)
@extension("x-speakeasy-name-override", "disable")
op disableBankAccount(
  ...CommonHeaders,

  @format("uuid")
  @path
  accountID: string,

  @format("uuid")
  @path
  bankAccountID: string,
): DisableResponses;
