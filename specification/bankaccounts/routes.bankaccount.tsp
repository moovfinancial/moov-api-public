import "@typespec/http";
import "./models.bankaccount.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";
import "../auth/models.auth.tsp";

using TypeSpec.Http;

namespace MoovAPI {
  @doc("""
    Link a bank account to an existing Moov account. Read our [bank accounts guide](https://docs.moov.io/guides/sources/bank-accounts/) to learn more.
    
    To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/bank-accounts.write` scope when generating a [token](https://docs.moov.io/api/authentication/access-tokens/).
    
    It is strongly recommended that callers include the `X-Wait-For` header, set to `payment-method`, if the newly linked
    bank-account is intended to be used right away. If this header is not included, the caller will need to poll the [List Payment
    Methods](https://docs.moov.io/api/sources/payment-methods/list/)
    endpoint to wait for the new payment methods to be available for use.
    """)
  @tag("Bank accounts")
  @route("/accounts/{accountID}/bank-accounts")
  @post
  @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/bank-accounts.write"]>)
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

  @doc("""
    List all the bank accounts associated with a particular Moov account. 
    
    Read our [bank accounts guide](https://docs.moov.io/guides/sources/bank-accounts/) to learn more. To use this endpoint 
    from the browser, you'll need to specify the `/accounts/{accountID}/bank-accounts.read` scope when generating a 
    [token](https://docs.moov.io/api/authentication/access-tokens/).
    """)
  @tag("Bank accounts")
  @route("/accounts/{accountID}/bank-accounts")
  @get
  @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/bank-accounts.read"]>)
  op listBankAccounts(
    ...CommonHeaders,

    @format("uuid")
    @path
    accountID: string,
  ): ListResponses<BankAccount>;

  @doc("""
    Retrieve bank account details (i.e. routing number or account type) associated with a specific Moov account. 
    
    Read our [bank accounts guide](https://docs.moov.io/guides/sources/bank-accounts/) to learn more. To use this 
    endpoint from the browser, you'll need to specify the `/accounts/{accountID}/bank-accounts.read` scope when 
    generating a [token](https://docs.moov.io/api/authentication/access-tokens/).
    """)
  @tag("Bank accounts")
  @route("/accounts/{accountID}/bank-accounts/{bankAccountID}")
  @get
  @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/bank-accounts.read"]>)
  op getBankAccount(
    ...CommonHeaders,

    @format("uuid")
    @path
    accountID: string,

    @format("uuid")
    @path
    bankAccountID: string,
  ): GetResponses<BankAccount>;

  @doc("""
    Discontinue using a specified bank account linked to a Moov account. 
    
    To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/bank-accounts.write` scope 
    when generating a [token](https://docs.moov.io/api/authentication/access-tokens/).
    """)
  @tag("Bank accounts")
  @route("/accounts/{accountID}/bank-accounts/{bankAccountID}")
  @delete
  @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/bank-accounts.write"]>)
  op disableBankAccount(
    ...CommonHeaders,

    @format("uuid")
    @path
    accountID: string,

    @format("uuid")
    @path
    bankAccountID: string,
  ): DisableResponses;
}
