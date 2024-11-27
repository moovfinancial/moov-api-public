import "@typespec/http";
import "./models.account.tsp";
import "../auth/models.auth.tsp";
import "../common/models.response.tsp";
import "../common/models.header.tsp";
import "../common/models.parameter.tsp";

using TypeSpec.Http;

namespace MoovAPI {
  @doc("""
    You can create **business** or **individual** accounts for your users (i.e., customers, merchants) by passing the required
    information to Moov. Requirements differ per account type and requested [capabilities](https://docs.moov.io/guides/accounts/capabilities/requirements/).
    
    If you're requesting the `wallet`, `send-funds`, `collect-funds`, or `card-issuing` capabilities, you'll need to:
      + Send Moov the user [platform terms of service agreement](https://docs.moov.io/guides/accounts/requirements/platform-agreement/) acceptance.
        This can be done upon account creation, or by [patching](https://docs.moov.io/api/moov-accounts/accounts/patch/) the account using the `termsOfService` field.
    If you're creating a business account with the business type `llc`, `partnership`, or `privateCorporation`, you'll need to:
      + Provide [business representatives](https://docs.moov.io/api/moov-accounts/representatives/) after creating the account.
      + [Patch](https://docs.moov.io/api/moov-accounts/accounts/patch/) the account to indicate that business representative ownership information is complete.
    
    Visit our documentation to read more about [creating accounts](https://docs.moov.io/guides/accounts/create-accounts/) and [verification requirements](https://docs.moov.io/guides/accounts/requirements/identity-verification/).
    Note that the `mode` field (for production or sandbox) is only required when creating a _facilitator_ account. All non-facilitator account requests will ignore the mode field and be set to the calling facilitator's mode.
    """)
  @tag("Accounts")
  @route("/accounts")
  @post
  @useAuth(BasicAuth | OAuth2<["/accounts.write"]>)
  op createAccount(
    ...CommonHeaders,

    @doc("Optional header that indicates whether to wait for the connection to be created before returning from the account creation.")
    @header
    xWaitFor?: AccountWaitFor,

    @body body: CreateAccount,
  ): PostResponses<
    Account,
    {
      error: CreateAccountError;
    }
  >;

  @doc("""
    List or search accounts to which the caller is connected.
    
    All supported query parameters are optional. If none are provided the response will include all connected accounts.
    Pagination is supported via the `skip` and `count` query parameters.
    Searching by name and email will overlap and return results based on relevance.
    """)
  @tag("Accounts")
  @route("/accounts")
  @get
  @useAuth(BasicAuth | OAuth2<["/accounts.read"]>)
  op listAccounts(
    ...CommonHeaders,
    ...AccountsQuery,
    @query skip: Skip,
    @query count: Count,
  ): ListResponses<Account>;

  @doc("Retrieves details for the account with the specified ID.")
  @tag("Accounts")
  @route("/accounts/{accountID}")
  @get
  @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/profile.read"]>)
  op getAccount(
    ...CommonHeaders,

    @format("uuid")
    @path
    accountID: string,
  ): GetResponses<Account>;

  @doc("""
    When **can** profile data be updated:
      + For unverified accounts, all profile data can be edited.
      + During the verification process, missing or incomplete profile data can be edited.
      + Verified accounts can only add missing profile data.
    
      When **can't** profile data be updated:
      + Verified accounts cannot change any existing profile data.
    
    If you need to update information in a locked state, please contact Moov support.
    
    To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/profile.write` scope when generating 
    a [token](https://docs.moov.io/api/authentication/access-tokens/), and provide the changed information.
    """)
  @tag("Accounts")
  @route("/accounts/{accountID}")
  @patch
  @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/profile.write"]>)
  op patchAccount(
    ...CommonHeaders,

    @format("uuid")
    @path
    accountID: string,

    @body body: CreateAccount,
  ): PostResponses<
    Account,
    {
      error: PatchAccountError;
    }
  >;

  @doc("""
      This will sever the connection between you and the account specified and it will no longer be listed as active in the list of accounts. 
      This also means you'll only have read-only access to the account going forward for reporting purposes.
    
      To use this endpoint from the browser, you'll need to specify the `/accounts/{accountID}/profile.disconnect` scope when generating 
      a [token](https://docs.moov.io/api/authentication/access-tokens/), and provide the changed information.
    """)
  @tag("Accounts")
  @route("/accounts/{accountID}")
  @delete
  @useAuth(BasicAuth | OAuth2<["/accounts/{accountID}/profile.disconnect"]>)
  op disconnectAccount(
    ...CommonHeaders,

    @format("uuid")
    @path
    accountID: string,
  ): DisableResponses;
}
